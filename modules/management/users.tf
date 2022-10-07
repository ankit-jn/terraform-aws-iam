resource aws_iam_user "this" {
    for_each= { for user in var.users : user.name => user }

    name                 = each.key
    path                 = lookup(each.value, "path", "/")
    force_destroy        = lookup(each.value, "force_destroy", "yes") == "yes" ? true : false
    permissions_boundary = lookup(each.value, "permissions_boundary", null)

    tags = var.users_default_tags
}

resource aws_iam_user_login_profile "this" {

    for_each= { for user in var.users : user.name => user  
                      if lookup(user, "create_login_profile", "no") == "yes"}

    user                    = aws_iam_user.this[each.key].name
    pgp_key                 = lookup(each.value, "pgp_key", "")
    password_length         = lookup(each.value, "password_length", 32)
    password_reset_required = lookup(each.value, "password_reset_required", "yes") == "yes" ? true : false

    lifecycle {
      ignore_changes = [password_reset_required]
    }
}

resource aws_iam_access_key "this" {
    for_each= { for user in var.users : user.name => user  
                      if (lookup(user, "create_access_key", "no") == "yes") && (lookup(user, "pgp_key", "") != "")}

    user    = aws_iam_user.this[each.key].name
    pgp_key = each.value.pgp_key
    status  = lookup(each.value, "access_key_status", "Active")
}

resource aws_iam_access_key "this_no_pgp" {
    for_each= { for user in var.users : user.name => user  
                      if (lookup(user, "create_access_key", "no") == "yes") && (lookup(user, "pgp_key", "") == "")}
  
    user    = aws_iam_user.this[each.key].name
    status  = lookup(each.value, "access_key_status", "Active")
}

resource aws_iam_user_ssh_key "this" {
    for_each= { for user in var.users : user.name => user  
                        if lookup(user, "upload_ssh_key", "no") == "yes"}

    username    = aws_iam_user.this[each.key].name
    encoding    = lookup(each.value, "encoding", "SSH")
    public_key  = each.value.ssh_public_key
    status      = lookup(each.value, "ssh_key_status", "active")
}

resource aws_iam_user_policy_attachment "force_mfa_attachment" {
    for_each= { for user in var.users : user.name => user  
                      if var.create_force_mfa_policy && lookup(user, "force_mfa", "yes") == "yes"}

    user = aws_iam_user.this[each.key].name
    policy_arn =  aws_iam_policy.force_mfa_policy[0].arn
}

resource aws_iam_user_group_membership "groups" {
    for_each= { for user in var.users : user.name => user 
                    if lookup(user, "groups", "") != ""}

    user    = aws_iam_user.this[each.key].name
    groups  = split(",", each.value.groups)
}
