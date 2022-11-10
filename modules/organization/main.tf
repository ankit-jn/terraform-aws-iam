###############################
## Create Organization
################################

resource aws_organizations_organization "this" {
    aws_service_access_principals = var.aws_service_access_principals
    enabled_policy_types          = var.enabled_policy_types
    feature_set                   = var.feature_set

    lifecycle {
        ignore_changes = [
            aws_service_access_principals,
            enabled_policy_types,
            feature_set
        ]
    }
}

################################
## Create Organizational Units 
################################
# Top level OUs in the hierarchy
resource aws_organizations_organizational_unit "level_1" {

    for_each = local.ou_level_1

    name      = each.key
    parent_id = aws_organizations_organization.this.roots[0].id
    tags = merge(
            {"Name" = format("%s", each.key)}, 
            var.organization_default_tags, 
            lookup(each.value, "tags", {})
        )
}

# Second level OUs in the hierarchy
resource aws_organizations_organizational_unit "level_2" {

    for_each = local.ou_level_2

    name      = each.key
    parent_id = aws_organizations_organizational_unit.level_1[each.value.parent].id
    tags = merge(
            {"Name" = format("%s", each.key)}, 
            var.organization_default_tags, 
            lookup(each.value, "tags", {})
        )
}

# Third level OUs in the hierarchy
resource aws_organizations_organizational_unit "level_3" {

    for_each = local.ou_level_3

    name      = each.key
    parent_id = aws_organizations_organizational_unit.level_2[each.value.parent].id
    tags = merge(
            {"Name" = format("%s", each.key)}, 
            var.organization_default_tags, 
            lookup(each.value, "tags", {})
        )
}

# Fourth level OUs in the hierarchy
resource aws_organizations_organizational_unit "level_4" {

    for_each = local.ou_level_4

    name      = each.key
    parent_id = aws_organizations_organizational_unit.level_3[each.value.parent].id
    tags = merge(
            {"Name" = format("%s", each.key)}, 
            var.organization_default_tags, 
            lookup(each.value, "tags", {})
        )
}

# Fifth level OUs in the hierarchy
resource aws_organizations_organizational_unit "level_5" {

    for_each = local.ou_level_5

    name      = each.key
    parent_id = aws_organizations_organizational_unit.level_3[each.value.parent].id
    tags = merge(
            {"Name" = format("%s", each.key)}, 
            var.organization_default_tags, 
            lookup(each.value, "tags", {})
        )
}

################################
##  Manage Organizations Policy  
################################

data template_file "policy_template" {
    for_each = { for policy in var.organizations_policies: policy.name => policy } 
    
    template = file("${path.root}/${each.value.policy_file}")
}

resource aws_organizations_policy "policy" {
    for_each = local.policy_contents

    name        = each.value.name
    description = each.value.description
    type        = each.value.type
    content     = each.value.policyjson

    tags = merge(
            {"Name" = format("%s", each.value.name)}, 
            var.organization_default_tags, 
            lookup(each.value, "tags", {})
        )
}

# Attach the Organization Policy to the Root
resource aws_organizations_policy_attachment "policy_attachment" {
  for_each = local.policy_contents

  policy_id = aws_organizations_policy.policy[each.key].id
  target_id = aws_organizations_organization.this.roots[0].id
}

##############################################
##  Create Member account in the Organization
##############################################

resource aws_organizations_account "this" {

    for_each = { for account in var.organizations_accounts : account.name => account }

    name      = each.value.name
    email     = each.value.email
    parent_id = aws_organizations_organization.this.roots[0].id
    role_name = each.value.role_name
    iam_user_access_to_billing = lookup(each.value, "access_to_billing", "ALLOW")

    tags = merge(
            {"Name" = format("%s", each.value.name)}, 
            var.organization_default_tags, 
            each.value.tags
        )
}
