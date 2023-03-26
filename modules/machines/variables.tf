# Global
variable "counter" {
  type = number
}
variable "instance" {
  type = string
}
variable "name_web" {
  type = object({
    dev  = string
    hom  = string
    prod = string
  })
}
# Web
variable "ami_ubuntu" {
  type = string
}
variable "aws_public_subnet" {
  type = list(string)
}
variable "aws_web_security_group" {
  type = list(string)
}
variable "volume_size_web" {
  type = number
}
variable "volume_type_web" {
  type = string
}
# Server
variable "ami_amazon_linux" {
  type = string
}
variable "aws_private_subnet" {
  type = list(string)
}
variable "aws_server_security_group" {
  type = list(string)
}
variable "volume_size_server" {
  type = number
}
variable "volume_type_server" {
  type = string
}