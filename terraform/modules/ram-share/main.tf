resource "aws_ram_resource_share" "this" {
  name = var.name

  allow_external_principals = var.allow_external_principals

  tags = var.tags
}  