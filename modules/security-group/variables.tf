variable "sg_name_web" {
 type = object({
   dev = string
   hom = string
   prod = string
 })
}
variable "sg_name_server" {
  type = object({
    dev = string
    hom = string
    prod = string
  })
}
variable "vpc" {
  type = string
}