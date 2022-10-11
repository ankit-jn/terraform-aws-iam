output "trusted_account_roles" {
    description = <<EOF
Map of all the IAM Roles for a trusted AWS account that are provisioned 
where each entry of the map is again a map of the Role attributes
EOF
    value = { 
        for role_name, role in aws_iam_role.trusted_account_roles : 
            role_name => 
                {
                    arn         = role.arn
                    unique_id   = role.unique_id
                    create_date = role.create_date
                    policies    = try(local.trusted_account_roles_policies_attachments[role_name], [])
                }
    }
}

output "service_linked_roles" {
    description = <<EOF
Map of all the IAM Roles for a trusted AWS Service that are provisioned 
where each entry of the map is again a map of the Role attributes
EOF
    value = { 
        for role_name, role in aws_iam_role.service_linked_roles : 
            role_name => 
                {
                    arn         = role.arn
                    unique_id   = role.unique_id
                    create_date = role.create_date
                    policies    = try(local.service_linked_roles_policies_attachments[role_name], [])
                }
    }
}