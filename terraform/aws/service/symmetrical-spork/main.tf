locals {
  env              = "dev"
}

module "symmetrical-spork" {
  source                       = "../../../modules/symmetrical-spork"
  project_full_name            = "${local.env}-symmetrical-spork"
  vpc_id                       = "vpc-xxxxx"
  instance_type                = "t2.medium"
  iam_role                     = "cadreon-${local.env}"
  ssh_key_name                 = "cad-${local.env}"
  default_security_groups_list = ["sg-xxxx"]

  subnets_list = [
        "subnet-xxxx", # dev-public-1a
        "subnet-xxxx", # dev-public-1b
  ]

  app_http_port               = 8080
  asg_max_size                = "4"
  asg_min_size                = "1"
  asg_desired_capacity        = "1"
  app_s3_location             = "${local.env}"
  asg_suffix                  = "${var.asg_suffix}"
  min_elb_capacity            = "${var.min_elb_capacity}"
  container_definitions       = "xxxx"
  providers = {
    "aws"     = "aws"
    "aws.r53" = "aws.r53"
  }
}
