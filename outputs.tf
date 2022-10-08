output "signin_url" {
    description = "SignIn URL based on alias"
    value       = format("https://%s.signin.aws.amazon.com/console", aws_iam_account_alias.this[0].account_alias)
}

output "organization_accounts" {
    description = <<EOF
Map of all the Organization accounts that are created as a member of the organization 
where each entry of the map is again a map of the Account attributes"
EOF
    value = try(module.iam_organization[0].organizations_accounts, {})
}

output "organizations_units" {
    description = <<EOF
Map of all the Organization Units that are created 
where each entry of the map is again a map of the OU attributes"
EOF
    value = try(module.iam_organization[0].organizations_units, {})
}

output "force_mfa_policy_arn" {
    description = "ARN of the MFA enforcement policy"
    value       = try(module.iam_management[0].force_mfa_policy_arn, "")
}

output "policies" {
    description = <<EOF
Map of all the IAM policies that are provisioned 
where each entry of the map is again a map of the policy attributes
EOF
    value = try(module.iam_policies.policies, {})
}

output "roles" {
    description = <<EOF
Map of all the IAM Roles that are provisioned 
where each entry of the map is again a map of the Role attributes
EOF
    value       = try(module.iam_roles.roles, {})
}

output "groups" {
    description = <<EOF
Map of all the IAM Groups that are provisioned 
where each entry of the map is again a map of the Group attributes like its ARN, and attached IAM policies
EOF
    value       = try(module.iam_management[0].groups, {})
}

output "users" {
    description = <<EOF
Map of all the IAM Users that are provisioned 
where each entry of the map is again a map of the User attributes, login profile details, 
and optionally the groups which the user will be part of.
EOF
    value       = try(module.iam_management[0].users, {})
}

