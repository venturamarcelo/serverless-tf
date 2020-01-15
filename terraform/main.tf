provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "marcelo-terraform"
    key    = "serverless-tf/terraform.tfstate"
    region = "us-west-2"
  }
}

# Main SNS Topic
resource "aws_sns_topic" "serverless_updates" {
  name = "serverless-updates${local.suffix}"
  tags = {
    Environment  = "${local.environment}"
  }
}
resource "aws_sns_topic_policy" "serverless_updates_policy" {
  arn    = "${aws_sns_topic.serverless_updates.arn}"
  policy = "${data.aws_iam_policy_document.sns_upload.json}"
}

# Lambda functions
module "uno" {
  source        = "./modules/function"
  function_name = "uno"
  sns_topic_arn = "${aws_sns_topic.serverless_updates.arn}"
  environment   = "${local.environment}"
  suffix        = "${local.suffix}"
  filter_policy = <<EOF
{
  "Event": ["Trigger Uno"]
}
EOF
}

module "dos" {
  source        = "./modules/function"
  function_name = "dos"
  sns_topic_arn = "${aws_sns_topic.serverless_updates.arn}"
  environment   = "${local.environment}"
  suffix        = "${local.suffix}"
  filter_policy = <<EOF
{
  "Event": ["Trigger Dos"]
}
EOF
} 

module "tres" {
  source        = "./modules/function"
  function_name = "tres"
  sns_topic_arn = "${aws_sns_topic.serverless_updates.arn}"
  environment   = "${local.environment}"
  suffix        = "${local.suffix}"
  filter_policy = <<EOF
{
  "Event": ["Trigger Tres"]
}
EOF
}