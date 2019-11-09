provider "aws" {}

provider "aws" {
  alias = "r53"
}

module "app_sg" {
  source            = "../app_sg"
  project_full_name = "${var.project_full_name}"
  vpc_id            = "${var.vpc_id}"
}

# Adds security group roule to Application SG to allow traffic from ELB
resource "aws_security_group_rule" "app_sg_rule_internal_elb" {
  security_group_id        = "${module.app_sg.app_security_group_id}"
  type                     = "ingress"
  from_port                = "${var.app_http_port}"
  to_port                  = "${var.app_http_port}"
  protocol                 = "tcp"
  source_security_group_id = "${module.elb_internal_sg.elb_security_group_id}"
  description              = "ELB Internal"
}

module "elb_sg" {
  source            = "../elb_sg"
  project_full_name = "${var.project_full_name}"
  vpc_id            = "${var.vpc_id}"
}

module "elb_internal_sg" {
  source            = "../elb_sg"
  project_full_name = "${var.project_full_name}-internal"
  vpc_id            = "${var.vpc_id}"
  elb_http_port     = 8443
}

module "elb_internal" {
  source                = "../elb"
  project_full_name     = "${var.project_full_name}-internal"
  elb_http_port         = 8443
  elb_listener_protocol = "https"
  elb_listener_cert_arn = "${data.aws_acm_certificate.test_wildcard.arn}"
  app_http_port         = "${var.app_http_port}"
  app_protocol          = "http"
  subnets_list          = ["${var.subnets_list}"]

  security_groups_list = [
    "${var.default_security_groups_list}",
    "${module.elb_internal_sg.elb_security_group_id}",
  ]

  elb_internal = true
}

module "lc-asg" {
  source               = "../lc-asg"
  project_full_name    = "${var.project_full_name}"
  asg_suffix           = "${var.asg_suffix}"
  instance_type        = "${var.instance_type}"
  ami_id               = "${var.ami_id}"
  iam_role             = "${var.iam_role}"
  ssh_key_name         = "${var.ssh_key_name}"
  security_groups_list = ["${var.default_security_groups_list}", "${module.app_sg.app_security_group_id}"]
  root_volume_size     = "${var.root_volume_size}"
  subnets_list         = ["${var.subnets_list}"]
  asg_max_size         = "${var.asg_max_size}"
  asg_min_size         = "${var.asg_min_size}"
  asg_desired_capacity = "${var.asg_desired_capacity}"
  min_elb_capacity     = "${var.min_elb_capacity}"

  load_balancers_list = ["${module.elb_internal.elb_name}"]
}

module "r53_record_elb" {
  source       = "../r53_record_cname"
  r53_dns_name = "${var.project_full_name}"
  dns_name     = "${module.elb_internal.elb_dns_name}"

  providers = {
    "aws" = "aws.r53"
  }
}

module "r53_record_rds" {
  source       = "../r53_record_cname"
  r53_dns_name = "${var.project_full_name}-db"
  dns_name     = "${module.rds_instance.rds_hostname}"

  providers = {
    "aws" = "aws.r53"
  }
}
module "ecs_fargate" {
  source                = "git::https://github.com/gdubey123/symmetrical-spork"
  name                  = "example"
  container_name        = "nginx"
  container_port        = "80"
  cluster               = "${var.ecs_cluster_arn}"
  subnets               = ["${var.subnets}"]
  target_group_arn      = "${var.target_group_arn}"
  vpc_id                = "${var.vpc_id}"
  container_definitions = "${var.container_definitions}"

  desired_count                      = 2
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  deployment_controller_type         = "ECS"
  assign_public_ip                   = true
  health_check_grace_period_seconds  = 10
  ingress_cidr_blocks                = ["0.0.0.0/0"]
  cpu                                = 256
  memory                             = 512
  requires_compatibilities           = ["FARGATE"]
  iam_path                           = "/service_role/"
  iam_description                    = "example description"
  enabled                            = true

  create_ecs_task_execution_role = false
  ecs_task_execution_role_arn    = "${var.ecs_task_execution_role_arn}"

  tags = {
    Environment = "dev"
  }
}

