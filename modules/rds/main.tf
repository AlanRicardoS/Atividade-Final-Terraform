resource "aws_rds_cluster" "example" {
  cluster_identifier     = "database-${terraform.workspace == "dev" ? var.db_name.dev : (terraform.workspace == "hom" ? var.db_name.hom : var.db_name.prod)}"
  engine                 = "aurora"
  engine_version         = "5.6.mysql_aurora.1.22.4"
  database_name          = "test"
  master_username        = "test"
  master_password        = "must_be_eight_characters"
  vpc_security_group_ids = var.aws_web_security_group

  serverlessv2_scaling_configuration {
    max_capacity = terraform.workspace == "prod" ? 2.0 : 0.5
    min_capacity = terraform.workspace == "prod" ? 1.0 : 0.5
  }
}

resource "aws_rds_cluster_instance" "example" {
  cluster_identifier = aws_rds_cluster.example.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.example.engine
  engine_version     = aws_rds_cluster.example.engine_version
}