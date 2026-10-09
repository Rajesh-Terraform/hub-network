output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "VPC CIDR"
  value       = aws_vpc.this.cidr_block
}

output "subnet_ids" {
  description = "Subnet IDs keyed by subnet name"
  value       = { for key, subnet in aws_subnet.this : key => subnet.id }
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = [for key in sort(keys(local.public_subnets)) : aws_subnet.this[key].id]
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = [for key in sort(keys(local.private_subnets)) : aws_subnet.this[key].id]
}

output "public_route_table_ids" {
  description = "Public route table IDs"
  value       = [for key in sort(keys(local.public_subnets)) : aws_route_table.this[key].id]
}

output "private_route_table_ids" {
  description = "Private route table IDs"
  value       = [for key in sort(keys(local.private_subnets)) : aws_route_table.this[key].id]
}

output "private_route_table_ids_by_subnet" {
  description = "Private route table IDs keyed by subnet name"
  value       = { for key in sort(keys(local.private_subnets)) : key => aws_route_table.this[key].id }
}

output "nat_gateway_ids" {
  description = "NAT Gateway IDs"
  value       = [for key in sort(keys(aws_nat_gateway.this)) : aws_nat_gateway.this[key].id]
}