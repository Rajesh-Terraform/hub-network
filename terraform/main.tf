module "hub_vpc" {
  source = "./modules/vpc"

  name               = var.hub_vpc_name
  cidr_block         = var.hub_vpc_cidr
  subnets            = var.subnets
  enable_nat_gateway = true
  tags               = var.tags
}

module "transit_gateway" {
  source = "./modules/transit-gateway"

  name                = var.transit_gateway_name
  amazon_side_asn     = var.transit_gateway_asn
  hub_vpc_id          = module.hub_vpc.vpc_id
  hub_vpc_cidr        = var.hub_vpc_cidr
  hub_subnet_ids      = module.hub_vpc.private_subnet_ids
  spoke_vpc_cidr      = var.spoke_vpc_cidr
  spoke_attachment_id = var.spoke_attachment_id
  tags                = var.tags
}

module "ram_share" {
  source = "./modules/ram-share"

  name                      = "${var.transit_gateway_name}-share"
  resource_arn              = module.transit_gateway.transit_gateway_arn
  principal                 = var.spoke_account_id
  allow_external_principals = var.allow_external_ram_principals
  tags                      = var.tags
}

module "hub_spoke_routes" {
  source = "./modules/vpc-tgw-routes"

  route_table_ids    = module.hub_vpc.private_route_table_ids_by_subnet
  destination_cidr   = var.spoke_vpc_cidr
  transit_gateway_id = module.transit_gateway.transit_gateway_id
}      