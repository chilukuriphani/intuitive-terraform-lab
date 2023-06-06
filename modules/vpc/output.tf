output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "VPC ID"
}

output "subnet_list" {
  value       = aws_subnet.subnets.*
  description = "List of subnets"
}
output "subnet_id" {
  value       = aws_subnet.subnets.*.id
  description = "List of subnet IDs"
}