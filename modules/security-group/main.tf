locals {
  ingress_rules_web = [
    {
      port        = 443,
      description = "Port 443"
    },
    {
      port = 80,
      description = "Port 80"
    }
  ]
  ingress_rules_server = {
    port        = 3306,
    description = "Port 3306"
  }
}
resource "aws_security_group" "web_security_group" {
  name   = "SG-web-${terraform.workspace == "dev" ? var.sg_name_web.dev : (terraform.workspace == "hom" ? var.sg_name_web.hom : var.sg_name_web.prod)}"
  vpc_id = var.vpc
  dynamic "ingress" {
    for_each = local.ingress_rules_web
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}



resource "aws_security_group" "server_security_group" {
  name   = "SG-server-${terraform.workspace == "dev" ? var.sg_name_server.dev : (terraform.workspace == "hom" ? var.sg_name_server.hom : var.sg_name_server.prod)}"
  vpc_id = var.vpc

  ingress {
    description = local.ingress_rules_server.description
    from_port   = local.ingress_rules_server.port
    to_port     = local.ingress_rules_server.port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


}