locals {
    iam_groups = [ for group in var.groups : {
                        name = group.name
                        policy_arns = concat(
                            [for policy in lookup(lookup(group, "policies", {}), "policy_arns", []):  {
                                "name" = policy
                                "arn" = policy
                                }],
                            [for policy in  lookup(lookup(group, "policies", {}), "policy_names", []):  {
                                "name" = policy
                                "arn" = module.iam_policies.policies[policy].arn
                                }]
                        )
                    }] 
}