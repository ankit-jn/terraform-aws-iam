output "roles" {
    description = <<EOF
Map of all the IAM Roles that are provisioned 
where each entry of the map is again a map of the Role attributes
EOF
    value = { 
        for role_name, role in aws_iam_role.this : 
            role_name => 
                {
                    arn         = role.arn
                    unique_id   = role.unique_id
                    create_date = role.create_date
                    policies    = local.role_policies[role_name]
                }
    }
}