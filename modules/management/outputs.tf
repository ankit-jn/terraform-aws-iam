output "force_mfa_policy_arn" {
    description = "ARN of Force MFA Policy"
    value = try(aws_iam_policy.force_mfa_policy[0].arn, "")
}

output "groups" {
    description = <<EOF
Map of all the IAM Groups that are provisioned 
where each entry of the map is again a map of the Group attributes like its ARN, and attached IAM policies
EOF
    value = { 
        for group_name, group in aws_iam_group.this : 
            group_name => 
                {
                    id   = group.id
                    arn  = group.arn
                    policies = try(local.group_policies[group_name], [])
                    assumable_roles_policy = try(local.group_cross_account_policies[group_name], "")
                }
    }
}

output "users" {
    description = <<EOF
Map of all the IAM Users that are provisioned 
where each entry of the map is again a map of the User attributes,
and optionally the groups which the user will be part of.
EOF
    value = { 
        for user_name, user in aws_iam_user.this : 
            user_name => 
                {
                    arn             = user.arn
                    unique_id       = user.unique_id
                    access_key_id   = try(aws_iam_access_key.this[user.name].id, aws_iam_access_key.this_no_pgp[user.name].id, "")
                    groups          = try(aws_iam_user_group_membership.groups[user.name].groups, [])
                }
    }
}