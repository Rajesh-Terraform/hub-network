variable "name" {
  description = "VPC and resource name prefix"
  type        = string
}

variable "cidr_block" {
  description = "VPC IPv4 CIDR"
  type        = string
}

variable "subnets" {
  description = "Subnet definitions keyed by a stable subnet name"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    public            = bool
  }))
}

variable "enable_nat_gateway" {
  description = "Create one NAT Gateway per private subnet, using a public subnet in the same AZ"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags applied to VPC resources"
  type        = map(string)
  default     = {}
}  