variable "name" {
  description = "RAM share name"
  type        = string
}

variable "allow_external_principals" {
  description = "Allow sharing with principals outside the AWS organization"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags for RAM resources"
  type        = map(string)
  default     = {}
}  