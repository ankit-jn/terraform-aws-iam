output "policies" {
    value = { 
        for polict_name, policy in aws_iam_policy.this : 
            polict_name => 
                {
                    policy_id               = policy.policy_id
                    arn                     = policy.arn
                }
    }
}