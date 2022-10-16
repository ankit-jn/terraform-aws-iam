locals {
  group_policies = {
        for attachment in aws_iam_group_policy_attachment.this:
            attachment.group => attachment.policy_arn...
        }


  user_creds = {
    for user in var.users:
      user.name => {
            access_key_id                   = try(aws_iam_access_key.this[user.name].id, aws_iam_access_key.this_no_pgp[user.name].id, "")
            need_password_decryption        = lookup(user, "create_login_profile", "no") == "yes" && lookup(user, "pgp_key_file", "") != ""
            need_secret_decryption          = lookup(user, "create_access_key", "no") == "yes" && lookup(user, "pgp_key_file", "") != ""
            encrypted_password              = try(aws_iam_user_login_profile.this[user.name].encrypted_password, "ERROR")
            encrypted_secret                = try(aws_iam_access_key.this[user.name].encrypted_secret, "ERROR")
      }
  }
}
