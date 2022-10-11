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
                        path = lookup(group, "path", "/")
                        policy_arns = concat(
                            [for policy in try(group.policy_map.policy_arns, []):  {
                                "name" = policy
                                "arn" = policy
                                }],
                            [for policy in  try(group.policy_map.policy_names, []):  {
                                "name" = policy
                                "arn" = module.iam_policies.policies[policy].arn
                                }]
                        )
                        assumable_roles = try(group.assumable_roles, [])
                    }] 

    trusted_account_roles = {for role_name, role in var.trusted_account_roles : role_name => {
                        name        = role.name
                        description = lookup(role, "description", role.name)
                        path        = lookup(role, "path", "/")
                        max_session_duration    = lookup(role, "max_session_duration", 3600)
                        force_detach_policies   = lookup(role, "force_detach_policies", false)
                        account_ids       = role.account_ids
                        policy_arns = concat(
                            [for policy in try(role.policy_map.policy_arns, []):  {
                                "name" = policy
                                "arn" = policy
                                }],
                            [for policy in  try(role.policy_map.policy_names, []):  {
                                "name" = policy
                                "arn" = module.iam_policies.policies[policy].arn
                                }]
                        )
                        tags = lookup(role, "tags", {})
                    }}

    service_linked_roles = {for role_name, role in var.service_linked_roles : role_name => {
                        name        = role.name
                        description = lookup(role, "description", role.name)
                        path        = lookup(role, "path", "/")
                        max_session_duration    = lookup(role, "max_session_duration", 3600)
                        force_detach_policies   = lookup(role, "force_detach_policies", false)
                        service_names       = role.service_names
                        policy_arns = concat(
                            [for policy in try(role.policy_map.policy_arns, []):  {
                                "name" = policy
                                "arn" = policy
                                }],
                            [for policy in  try(role.policy_map.policy_names, []):  {
                                "name" = policy
                                "arn" = module.iam_policies.policies[policy].arn
                                }]
                        )
                        tags = lookup(role, "tags", {})
                    }}
}