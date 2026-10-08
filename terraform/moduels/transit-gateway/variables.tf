variable "name" {
  description = "Transit Gateway name"
  type        = string
}

variable "amazon_side_asn" {
  description = "Amazon-side BGP ASN"
  type        = number
}

variable "hub_vpc_id" {
  description = "Hub VPC ID to attach"
  type        = string
}

variable "hub_vpc_cidr" {
  description = "Hub CIDR for the TGW route"
  type        = string
}

variable "hub_subnet_ids" {
  description = "One private subnet per hub AZ for the TGW attachment"
  type        = list(string)
}

variable "spoke_vpc_cidr" {
  description = "Spoke CIDR for the TGW route"
  type        = string
}

variable "spoke_attachment_id" {
  description = "Spoke attachment ID, supplied after the spoke creates it"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}  