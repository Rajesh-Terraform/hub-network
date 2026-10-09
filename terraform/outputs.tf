output "hub_vpc_id" {
  description = "Hub VPC ID"
  value       = module.hub_vpc.vpc_id
}

output "hub_vpc_cidr" {
  description = "Hub VPC CIDR"
  value       = var.hub_vpc_cidr
}

output "hub_public_subnet_ids" {
  description = "Hub public subnet IDs"
  value       = module.hub_vpc.public_subnet_ids
}

output "hub_private_subnet_ids" {
  description = "Hub private subnet IDs"
  value       = module.hub_vpc.private_subnet_ids
}

output "transit_gateway_id" {
  description = "Shared Transit Gateway ID to provide to the spoke deployment"
  value       = module.transit_gateway.transit_gateway_id
}

output "transit_gateway_arn" {
  description = "Shared Transit Gateway ARN"
  value       = module.transit_gateway.transit_gateway_arn
}

output "ram_resource_share_arn" {
  description = "RAM share ARN to provide to the spoke deployment"
  value       = module.ram_share.resource_share_arn
}

output "hub_attachment_id" {
  description = "Hub VPC attachment ID"
  value       = module.transit_gateway.hub_attachment_id
}

output "transit_gateway_route_table_id" {
  description = "Hub Transit Gateway route table ID"
  value       = module.transit_gateway.route_table_id
}    