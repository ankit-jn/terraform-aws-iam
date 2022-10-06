output "groups" {
    value = { 
        for group_name, group in aws_iam_group.this : 
            group_name => 
                {
                    id   = group.id
                    arn  = group.arn
                    policies = local.group_policies[group_name]
                }
    }
}
