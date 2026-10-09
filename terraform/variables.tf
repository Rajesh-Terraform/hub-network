variable "aws_region" {
  description = "AWS region for the hub network"
  type        = string
  default     = "ap-south-1"
}

variable "hub_vpc_name" {
  description = "Name prefix for the hub VPC resources"
  type        = string
  default     = "hub-network"
}

variable "hub_vpc_cidr" {
  description = "IPv4 CIDR for the hub VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnets" {
  description = "Hub subnet definitions keyed by a stable subnet name"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    public            = bool
  }))
}

variable "transit_gateway_name" {
  description = "Name of the shared hub Transit Gateway"
  type        = string
  default     = "hub-tgw"
}

variable "transit_gateway_asn" {
  description = "Amazon-side BGP ASN for the Transit Gateway"
  type        = number
  default     = 64512
}

variable "spoke_account_id" {
  description = "AWS account ID of the spoke allowed to use the Transit Gateway"
  type        = string
}

variable "spoke_vpc_cidr" {
  description = "Spoke VPC CIDR used for hub routes"
  type        = string
  default     = "10.1.0.0/16"
}

variable "spoke_attachment_id" {
  description = "Spoke TGW attachment ID; set after the spoke creates its attachment"
  type        = string
  default     = ""
}

variable "allow_external_ram_principals" {
  description = "Allow RAM sharing outside the AWS Organization when required"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags applied to hub resources"
  type        = map(string)
  default     = {}
}  

 