variable "aws_region" {
  description = "AWS region containing the hub VPC"
  type        = string
  default     = "ap-south-1"
}

variable "hub_vpc_id" {
  description = "ID of the deployed hub VPC"
  type        = string
}

variable "hub_private_subnet_id" {
  description = "ID of a private subnet in the hub VPC"
  type        = string
}

variable "tags" {
  description = "Tags applied to the Phase 5 instance and security group"
  type        = map(string)
  default     = {}
}
