output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "subnet_public" {
  value = aws_subnet.public_subnet[*].id
}
output "subnet_private" {
  value = aws_subnet.private_subnet[*].id
}