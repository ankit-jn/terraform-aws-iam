output "signin_url" {
    description = "SignIn URL based on alias"
    value = format("https://%s.signin.aws.amazon.com/console", aws_iam_account_alias.this[0].account_alias)
}

output "organization_accounts" {
    description = "Accounts which are created within Organizations"
    value = try(module.iam_organization[0].organizations_accounts, {})
}

output "policies" {
    description = "The List of Policies created in Management Account"
    value = try(module.iam_policies.policies, {})
}

output "roles" {
    description = "The List of Roles created in Standard Account"
    value = try(module.iam_roles.roles, {})
}

output "groups" {
    description = "The List of IAM Groups provisioned"
    value = try(module.iam_management[0].groups, {})
}

output "users" {
    description = "The List of Users provisioned"
    value = try(module.iam_management[0].users, {})
}

output "force_mfa_policy_arn" {
    description = "ARN of Force MFA Policy"
    value = try(module.iam_management[0].force_mfa_policy_arn, "")
}
