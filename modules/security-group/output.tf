output "sg_web_id" {
  value = aws_security_group.web_security_group.id
}
output "sg_server_id" {
  value = aws_security_group.server_security_group.id
}