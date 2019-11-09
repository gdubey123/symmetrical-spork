output app_security_group_id {
  value = "${module.symmetrical-spork.app_security_group_id}"
}

output elb_security_group_id {
  value = "${module.symmetrical-spork.elb_security_group_id}"
}

output elb_internal_security_group_id {
  value = "${module.symmetrical-spork.elb_internal_security_group_id}"
}

output elb_internal_dns_name {
  value = "${module.symmetrical-spork.elb_internal_dns_name}"
}

output elb_r53_record_name {
  value = "${module.symmetrical-spork.r53_record_elb}"
}

output app_iam_user_name {
  value = "${module.symmetrical-spork.app_iam_user_name}"
}

output app_iam_user_access_key {
  value = "${module.symmetrical-spork.app_iam_user_access_key}"
}

output app_iam_user_secret_key {
  value = "${module.symmetrical-spork.app_iam_user_secret_key}"
}
