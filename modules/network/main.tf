resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = "VPC-${terraform.workspace == "dev" ? var.vpc_name.dev : (terraform.workspace == "hom" ? var.vpc_name.hom : var.vpc_name.prod)}"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "InternetGateway-${terraform.workspace == "dev" ? var.gateway_name.dev : (terraform.workspace == "hom" ? var.gateway_name.hom : var.gateway_name.prod)}"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = var.sub_public_count
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.20.${10 + count.index}.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Sub-${terraform.workspace == "dev" ? var.subnet_name.dev : (terraform.workspace == "hom" ? var.subnet_name.hom : var.subnet_name.prod)}"
  }
}

resource "aws_subnet" "private_subnet" {
  count                   = var.sub_public_count
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.20.${20 + count.index}.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "PrivateSubnet-${terraform.workspace == "dev" ? var.subnet_name.dev : (terraform.workspace == "hom" ? var.subnet_name.hom : var.subnet_name.prod)}"
  }
}
