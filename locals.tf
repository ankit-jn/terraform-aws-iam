locals {
    managed_accounts = [ for account in var.organizations_accounts: {
            name      = account.name,
            email     = account.email,
            role_name = lookup(account, "role_name", "admin")
            tags = can(account.tags) ? account.tags : {}
        }]

    managed_accounts_configs = [ for account in var.organizations_accounts: {
            name      = account.name
        }]
        
    iam_groups = [ for group in var.groups : {
                        name = group.name
                        policy_arns = concat(
                            [for policy in try(group.policies.policy_arns, []):  {
                                "name" = policy
                                "arn" = policy
                                }],
                            [for policy in  try(group.policies.policy_names, []):  {
                                "name" = policy
                                "arn" = module.iam_policies.policies[policy].arn
                                }]
                        )
                        assumable_roles = try(group.assumable_roles, [])
                    }] 

    iam_roles = {for role_name, role in var.roles : role_name => {
                        name = role.name
                        description = lookup(role, "description", role.name)
                        path = lookup(role, "path", "/")
                        tags = can(role.tags) ? role.tags : {}
                        max_session_duration    = lookup(role, "max_session_duration", 3600)
                        trust_account_ids = lookup(role, "trust_account_ids", "") != "" ? role.trust_account_ids : var.trust_account_ids
                        policy_arns = concat(
                            [for policy in try(role.policies.policy_arns, []):  {
                                "name" = policy
                                "arn" = policy
                                }],
                            [for policy in  try(role.policies.policy_names, []):  {
                                "name" = policy
                                "arn" = module.iam_policies.policies[policy].arn
                                }]
                        )
                    }}
}