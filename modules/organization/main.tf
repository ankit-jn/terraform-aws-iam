###############################
## Organization
################################

resource aws_organizations_organization "this" {
    aws_service_access_principals = var.aws_service_access_principals
    enabled_policy_types          = var.enabled_policy_types
    feature_set                   = var.feature_set
}

################################
## Organizational Units 
################################

resource aws_organizations_organizational_unit "this" {

    for_each = { for ou in var.organization_units : ou.name => ou }

    name      = each.value.name
    parent_id = length(each.value.parent_id) > 0 ? each.value.parent_id : aws_organizations_organization.this.roots[0].id
    
    tags      = merge(var.organization_default_tags, can(each.value.tags) ? each.value.tags : {})
}

################################
##  Organizations Policy  
################################

data template_file "policy_template" {
    for_each = { for policy in var.organizations_policies: policy.name => policy } 
    
    template = file("${path.root}/org_policies/${each.key}.json")
}

resource aws_organizations_policy "policy" {
    for_each = local.policy_contents

    name        = each.value.name
    description = each.value.description
    type        = each.value.type
    content     = each.value.policyjson

    tags      = merge(var.organization_default_tags, can(each.value.tags) ? each.value.tags : {})
}

# resource aws_organizations_policy_attachment "policy_attachment" {
#   count = length(var.target_id) > 0 ? length(var.target_id) : 0

#   policy_id = local.policy_id[0]
#   target_id = tolist(var.target_id)[count.index]
# }

################################
##  Organizations Accounts 
################################
resource aws_organizations_account "this" {

    for_each = { for account in var.organizations_accounts : account.name => account }

    name      = each.value.name
    email     = each.value.email
    parent_id = aws_organizations_organization.this.roots[0].id
    role_name = each.value.role_name

    tags      = merge(var.organization_default_tags, each.value.tags)
}
