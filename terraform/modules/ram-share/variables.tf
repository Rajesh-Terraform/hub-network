variable "name" {
  description = "RAM resource share name"
  type        = string
}

variable "resource_arn" {
  description = "Resource ARN to share"
  type        = string
}

variable "principal" {
  description = "AWS account, organization, or OU to share with"
  type        = string
}

variable "allow_external_principals" {
  description = "Whether to allow sharing outside the AWS Organization"
  type        = bool
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}        