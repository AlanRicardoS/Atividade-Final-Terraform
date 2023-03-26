terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "./modules/network"
  vpc_name = {
    dev  = "dev"
    hom  = "hom"
    prod = "prod"
  }
  cidr_block           = "10.20.0.0/16"
  enable_dns_hostnames = true
  sub_public_count     = 3
  sub_private_count    = 3
  gateway_name = {
    dev  = "dev"
    hom  = "hom"
    prod = "prod"
  }
  subnet_name = {
    dev  = "dev"
    hom  = "hom"
    prod = "prod"
  }
}

module "security_group" {
  source = "./modules/security-group"

  sg_name_server = {
    dev  = "dev"
    hom  = "hom"
    prod = "prod"
  }
  sg_name_web = {
    dev  = "dev"
    hom  = "hom"
    prod = "prod"
  }
  vpc = module.network.vpc_id
}

module "machines" {
  source = "./modules/machines"

  name_web = {
    dev  = "dev"
    hom  = "hom"
    prod = "prod"
  }
  counter  = 5
  instance = "t2.micro"

  ami_ubuntu             = "ami-0557a15b87f6559cf"
  aws_public_subnet      = module.network.subnet_public
  aws_web_security_group = [module.security_group.sg_web_id]
  volume_size_web        = 20
  volume_type_web        = "gp3"

  ami_amazon_linux          = "ami-00c39f71452c08778"
  aws_private_subnet        = module.network.subnet_private
  aws_server_security_group = [module.security_group.sg_server_id]
  volume_size_server        = terraform.workspace == "dev" ? 10 : (terraform.workspace == "hom" ? 20 : 50)
  volume_type_server        = "gp3"
}

module "rds" {
  source = "./modules/rds"

  db_name = {
    dev  = "dev"
    hom  = "hom"
    prod = "prod"
  }
  aws_web_security_group = [module.security_group.sg_server_id]
}