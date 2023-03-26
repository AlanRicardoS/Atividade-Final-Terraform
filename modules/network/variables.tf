variable "vpc_name" {
  type = object({
    dev = string
    hom = string
    prod = string
  })
}
variable "cidr_block" {
  type = string
}
variable "enable_dns_hostnames" {
  type = bool
}
variable "gateway_name" {
  type =object({
    dev = string
    hom = string
    prod = string
  })
}
variable "sub_public_count" {
  type = string
}
variable "sub_private_count" {
  type = string
}
variable "subnet_name" {
  type = object({
    dev = string
    hom = string
    prod = string
  })
}