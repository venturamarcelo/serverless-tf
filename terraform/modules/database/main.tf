resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier      = "${var.dbInstanceIdentifier}-${local.cleansuffix}"
  engine                  = "${var.engine}"
  engine_mode             = "serverless"
  availability_zones      = ["us-west-2a", "us-west-2b", "us-west-2c"]
  database_name           = "${var.database_name}${local.cleansuffix}"
  master_username         = "${var.username}"
  master_password         = "${var.password}"
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  tags = {
    Environment  = "${var.environment}"
  }
}

resource "aws_secretsmanager_secret" "db-secret" {
  name = "award-comparison-db-secret${var.suffix}"
}

resource "aws_secretsmanager_secret_version" "db-secret-version" {
  secret_id     = "${aws_secretsmanager_secret.db-secret.id}"
  lifecycle {
    ignore_changes = [
      "secret_string"
    ]
  }
  secret_string = <<EOF
{
  "username": "${var.username}",
  "password": "${var.password}",
  "engine": "${var.engine}",
  "host": "${var.host}",
  "port": ${var.port},
  "dbInstanceIdentifier": "${var.dbInstanceIdentifier}-${local.cleansuffix}"
}
EOF
}

resource "null_resource" "setup_db" {	
  depends_on = ["aws_rds_cluster.rds_cluster"] #wait for the db to be ready	
  triggers = {
    always_run = "${timestamp()}"
  }	
  provisioner "local-exec" {
      #command = "./${path.module}/db_setup.sh ${aws_rds_cluster.rds_cluster.endpoint} ${aws_rds_cluster.rds_cluster.database_name} ${aws_rds_cluster.rds_cluster.master_username}"	
      command = "ls"
      environment = {	
          PGPASSWORD = "${var.password}"	
        }	
    }	
}