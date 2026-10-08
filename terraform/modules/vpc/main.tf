locals {
  public_subnets = {
    for key, subnet in var.subnets : key => subnet if subnet.public
  }
  private_subnets = {
    for key, subnet in var.subnets : key => subnet if !subnet.public
  }
}

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = var.name
  })
}

resource "aws_internet_gateway" "this" {
  count  = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.name}-igw"
  })
}

resource "aws_subnet" "this" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.public

  tags = merge(var.tags, {
    Name = "${var.name}-${each.key}"
    Tier = each.value.public ? "public" : "private"
  })
}

resource "aws_route_table" "this" {
  for_each = var.subnets

  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.name}-${each.key}-rt"
    Tier = each.value.public ? "public" : "private"
  })
}

resource "aws_route_table_association" "this" {
  for_each = var.subnets

  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.this[each.key].id
}

resource "aws_route" "public_internet" {
  for_each = local.public_subnets

  route_table_id         = aws_route_table.this[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id
}

resource "aws_eip" "nat" {
  for_each = var.enable_nat_gateway ? local.private_subnets : {}

  domain = "vpc"

  tags = merge(var.tags, {
    Name = "${var.name}-${each.key}-nat-eip"
  })
}

resource "aws_nat_gateway" "this" {
  for_each = var.enable_nat_gateway ? local.private_subnets : {}

  allocation_id = aws_eip.nat[each.key].id
  subnet_id = aws_subnet.this[one([
    for public_key, public_subnet in local.public_subnets : public_key
    if public_subnet.availability_zone == each.value.availability_zone
  ])].id

  depends_on = [aws_internet_gateway.this]

  tags = merge(var.tags, {
    Name = "${var.name}-${each.key}-nat"
  })
}

resource "aws_route" "private_nat" {
  for_each = var.enable_nat_gateway ? local.private_subnets : {}

  route_table_id         = aws_route_table.this[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[each.key].id
} 