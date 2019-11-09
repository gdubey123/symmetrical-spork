variable project_full_name {
  type = "string"
}

variable vpc_id {
  type = "string"
}

variable instance_type {
  type = "string"
}

variable ami_id {
  type = "string"
}

variable iam_role {
  type = "string"
}

variable ssh_key_name {
  type = "string"
}

variable default_security_groups_list {
  type = "list"
}

variable repo_releasever {
  type    = "string"
  default = "2017.09"
}

variable subnets_list {
  type = "list"
}

variable asg_max_size {
  type = "string"
}

variable asg_min_size {
  type = "string"
}

variable asg_desired_capacity {
  type = "string"
}

variable app_http_port {
  type    = "string"
  default = "8080"
}


variable asg_suffix {
  type    = "string"
  default = ""
}

variable min_elb_capacity {
  type    = "string"
  default = "0"
}

variable wait_for_capacity_timeout {
  type    = "string"
  default = "50m"
}

variable rds_backup_retention_period {
  type = "string"
}

variable app_bucket_name {
  type = "string"
}

variable app_s3_location {
  type = "string"
}

