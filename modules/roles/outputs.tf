output "roles" {
    value = { 
        for role_name, role in aws_iam_role.this : 
            role_name => 
                {
                    id          = role.id
                    arn         = role.arn
                    unique_id   = role.unique_id
                    create_date = role.create_date
                    policies    = local.role_policies[role_name]
                }
    }
}