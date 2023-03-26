variable "db_name" {
  type = object({
    dev  = string
    hom  = string
    prod = string
  })
}
variable "aws_web_security_group" {
  type = list(string)
}