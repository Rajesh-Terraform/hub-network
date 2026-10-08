resource "aws_ec2_transit_gateway" "this" {
  description                     = "${var.name} shared hub Transit Gateway"
  amazon_side_asn                 = var.amazon_side_asn
  auto_accept_shared_attachments  = "enable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  dns_support                     = "enable"

  tags = merge(var.tags, {
    Name = var.name
  })
}

resource "aws_ec2_transit_gateway_vpc_attachment" "hub" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = var.hub_vpc_id
  subnet_ids         = var.hub_subnet_ids
  dns_support        = "enable"

  tags = merge(var.tags, {
    Name = "${var.name}-hub-attachment"
  })
}

resource "aws_ec2_transit_gateway_route_table" "this" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id

  tags = merge(var.tags, {
    Name = "${var.name}-main"
  })
}

resource "aws_ec2_transit_gateway_route_table_association" "hub" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.hub.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id
}

resource "aws_ec2_transit_gateway_route" "hub" {
  destination_cidr_block         = var.hub_vpc_cidr
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.hub.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id

  depends_on = [aws_ec2_transit_gateway_route_table_association.hub]
}

resource "aws_ec2_transit_gateway_route_table_association" "spoke" {
  count = var.spoke_attachment_id == "" ? 0 : 1

  transit_gateway_attachment_id  = var.spoke_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id
}

resource "aws_ec2_transit_gateway_route" "spoke" {
  count = var.spoke_attachment_id == "" ? 0 : 1

  destination_cidr_block         = var.spoke_vpc_cidr
  transit_gateway_attachment_id  = var.spoke_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id

  depends_on = [aws_ec2_transit_gateway_route_table_association.spoke]
}  