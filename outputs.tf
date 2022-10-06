output "signin_url" {
    description = "SignIn URL based on alias"
    value = format("https://%s.signin.aws.amazon.com/console", aws_iam_account_alias.this.account_alias)
}

output "policies" {
    description = "The List of Policies created"
    value = module.iam_policies.policies
}

output "groups" {
    description = "The List of IAM Groups provisioned"
    value = module.iam_groups.groups
}

output "users" {
    description = "The List of Users provisioned"
    value = module.iam_users.users
}

output "force_mfa_policy_arn" {
    description = "ARN of Force MFA Policy"
    value = aws_iam_policy.force_mfa_policy[0].arn
}
