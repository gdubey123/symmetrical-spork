output app_security_group_id {
  value = "${module.app_sg.app_security_group_id}"
}

output elb_security_group_id {
  value = "${module.elb_sg.elb_security_group_id}"
}

output elb_internal_security_group_id {
  value = "${module.elb_internal_sg.elb_security_group_id}"
}

output launch_configuration_name {
  value = "${module.lc-asg.launch_configuration_name}"
}

output elb_internal_dns_name {
  value = "${module.elb_internal.elb_dns_name}"
}

output asg_name {
  value = "${module.lc-asg.asg_name}"
}

output r53_record_elb {
  value = "${module.r53_record_elb.r53_record_name}"
}

output app_iam_user_name {
  value = "${module.app_iam_user.app_iam_user_name}"
}

output app_iam_user_access_key {
  value = "${module.app_iam_user.app_iam_user_access_key}"
}

output app_iam_user_secret_key {
  value = "${module.app_iam_user.app_iam_user_secret_key}"
}
