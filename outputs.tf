output "console_login_url" {
  value = "https://${data.aws_caller_identity.current.account_id}.signin.aws.amazon.com/console"
}

output "username" {
  value = "${module.iam_user.this_iam_user_name}"
}

output "password" {
  value = "${module.iam_user.keybase_password_decrypt_command}"
}

output "access_key" {
  value = "${module.iam_user.this_iam_access_key_id}"
}

output "secret_key" {
  value = "${module.iam_user.keybase_secret_key_decrypt_command}"
}

output "azs" {
  value = "${data.aws_availability_zones.all_azs.names}"
}

output "region" {
  value = "${var.region}"
}

output "credentials" {
  value = "${
    map(
      "console_login_url",          "https://${data.aws_caller_identity.current.account_id}.signin.aws.amazon.com/console",
      "username",                   "${module.iam_user.this_iam_user_name}",
      "password decrypt command",   "${module.iam_user.keybase_password_decrypt_command}",
      "access_key",                 "${module.iam_user.this_iam_access_key_id}",
      "secret_key decrypt command", "${module.iam_user.keybase_secret_key_decrypt_command}",
      "region",                     "${var.region}"
    )
  }"
}
