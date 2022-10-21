locals {
    policy_contents = { for policy in var.organizations_policies : 
                            policy.name => merge(policy, { "policyjson" : data.template_file.policy_template[policy.name].rendered })}


    ## Segregate the List of Organization Unit into set of variables based on Levels
    ou_level_1 = { for ou in var.organization_units : ou.name => ou if lookup(ou, "parent", 0) == 0 }
    ou_level_2 = { for ou in var.organization_units : ou.name => ou 
                        if can(ou.parent) ? contains(keys(local.ou_level_1), ou.parent) : false }
    ou_level_3 = { for ou in var.organization_units : ou.name => ou 
                        if can(ou.parent) ? contains(keys(local.ou_level_2), ou.parent) : false }
    ou_level_4 = { for ou in var.organization_units : ou.name => ou 
                        if can(ou.parent) ? contains(keys(local.ou_level_3), ou.parent) : false }
    ou_level_5 = { for ou in var.organization_units : ou.name => ou 
                        if can(ou.parent) ? contains(keys(local.ou_level_4), ou.parent) : false }
}