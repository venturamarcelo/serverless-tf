
data "aws_iam_policy_document" "sns_upload" {
  policy_id = "snssqssns"

  statement {
    actions = [
      "SNS:Publish",
    ]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"

      values = [
        "arn:aws:s3:::*",
      ]
    }

    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "*",
      ]
    }

    resources = [
      "arn:aws:sns:*:*:*",
    ]

    sid = "snssqssnss3upload"
  }
}

variable "workspace_to_suffix_map" {
  type = "map"
  default = {
    prod    = ""
    qa      = "-qa"
  }
}
variable "workspace_to_environment_map" {
  type = "map"
  default = {
    prod    = "prod"
    qa      = "qa"
  }
}

locals {
  environment = "${lookup(var.workspace_to_environment_map, terraform.workspace, "dev")}"
  suffix       = "${lookup(var.workspace_to_suffix_map, terraform.workspace, "-"+terraform.workspace)}"
}

 