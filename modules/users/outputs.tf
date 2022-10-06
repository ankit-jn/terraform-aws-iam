output "users" {
    value = { 
        for user_name, user in aws_iam_user.this : 
            user_name => 
                {
                    arn                                 = user.arn
                    unique_id                           = user.unique_id
                    login_profile_key_fingerprint       = try(aws_iam_user_login_profile.this[user.name].key_fingerprint, "")
                    login_profile_encrypted_password    = try(aws_iam_user_login_profile.this[user.name].encrypted_password, "")
                    login_profile_password              = lookup(try(aws_iam_user_login_profile.this[user.name], {}), "password", sensitive(""))

                    access_key_id       = try(aws_iam_access_key.this[user.name].id, aws_iam_access_key.this_no_pgp[user.name].id, "")
                    access_key_secret   = try(aws_iam_access_key.this_no_pgp[user.name].secret, sensitive(""))

                    password_decrypt_command    = "echo '${try(aws_iam_user_login_profile.this[user.name].encrypted_password, "")}' | base64 --decode | keybase pgp decrypt"
                    secret_key_decrypt_command  = "echo '${try(aws_iam_access_key.this[user.name].encrypted_secret, "")}' | base64 --decode | keybase pgp decrypt"

                    groups = try(aws_iam_user_group_membership.groups[user.name].groups, [])
                }
    }
}