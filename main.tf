## Manages the account alias for the AWS Account
resource aws_iam_account_alias "this" {
    count = var.account_alias != "" ? 1 : 0
    account_alias =  var.account_alias
}

module "iam_organization" {
    source = "./modules/organization"

    count = var.organization_account ? 1 : 0
    
    aws_service_access_principals = var.aws_service_access_principals
    enabled_policy_types          = var.enabled_policy_types
    feature_set                   = var.feature_set

    organization_units            = var.organization_units
    organizations_policies        = var.organizations_policies
    organizations_accounts        = local.managed_accounts

    organization_default_tags     = var.organization_default_tags
}

module "iam_management" {
    source = "./modules/management"

    count = var.identity_account ? 1 : 0

    manage_account_password_policy  = var.manage_account_password_policy
    password_policy                 = var.password_policy

    create_force_mfa_policy         = var.create_force_mfa_policy
    mfa_policy_tags                 = var.policy_default_tags
    
    groups = local.iam_groups
    users = var.users
    
    users_default_tags = var.users_default_tags

}

module "iam_policies" {
  source = "./modules/policies"  

  policies = var.policies
  default_tags = var.policy_default_tags
}

module "iam_roles" {
    source = "./modules/roles"  

    trusted_account_roles = local.trusted_account_roles
    service_linked_roles = local.service_linked_roles

    default_tags = var.role_default_tags
}
