variable "route_table_ids" {
  description = "VPC route table IDs to update, keyed by stable subnet name"
  type        = map(string)
}

variable "destination_cidr" {
  description = "Remote VPC CIDR"
  type        = string
}

variable "transit_gateway_id" {
  description = "Transit Gateway ID used as the route target"
  type        = string
}  