data "aws_caller_identity" "current" {}

# Configure the AWS Provider
provider "aws" {
  region = "${var.region}"
}

data "aws_availability_zones" "all_azs" {}

# locals {
#   count       = "${length(data.aws_availability_zones.all_azs.names)}"
#   cidr_blocks = "${cidrsubnet("10.0.0.0/16", 8, count.index)}"
# }

# resource "null_resource" "cidrs" {
#   count = "${length(data.aws_availability_zones.all_azs.names)}"

#   triggers {
#     list = "${cidrsubnet("10.0.0.0/16", 8, count.index)}
#   }
# }

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.username}"
  cidr = "10.0.0.0/16"

  azs = ["${data.aws_availability_zones.all_azs.names[0]}", "${data.aws_availability_zones.all_azs.names[1]}"]

  public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  #TODO create a cidr fo each az
  # public_subnets = "[${local.cidr_blocks}]"

  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Terraform   = "true"
    Environment = "${var.username}"
  }
}

module "iam_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"

  name                    = "${var.username}"
  force_destroy           = true
  pgp_key                 = "keybase:${var.keybase-user}"
  password_reset_required = false
}

resource "aws_iam_policy_attachment" "policy-attach" {
  name       = "${var.username}-attachment"
  users      = ["${module.iam_user.this_iam_user_name}"]
  policy_arn = "${module.iam_policy.arn}"
}

data "template_file" "policy_file" {
  template = "${file("${path.module}/policy.tpl")}"

  vars = {
    REGION         = "${var.region}"
    ACCOUNT_NUMBER = "${data.aws_caller_identity.current.account_id}"
    VPC_ID         = "${module.vpc.vpc_id}"
  }
}

module "iam_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "${var.username}"
  path        = "/"
  description = "${var.username} vpc lockdown policy"

  policy = "${data.template_file.policy_file.rendered}"
}
