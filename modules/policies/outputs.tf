output "policies" {
    description = <<EOF
Map of all the IAM policies that are provisioned 
where each entry of the map is again a map of the policy attributes
EOF
    value = { 
        for polict_name, policy in aws_iam_policy.this : 
            polict_name => 
                {
                    policy_id               = policy.policy_id
                    arn                     = policy.arn
                }
    }
}