output "resource_share_arn" {
  description = "RAM share ARN"
  value       = aws_ram_resource_share.this.arn
}

output "resource_share_id" {
  description = "RAM share ID"
  value       = aws_ram_resource_share.this.id
}   