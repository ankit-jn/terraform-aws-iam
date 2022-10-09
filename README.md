# ARJ-Stack: AWS IAM Terraform module

A Terraform module for configuring IAM (Organization, Groups, Users, Polcies etc.) in AWS.

---
## Resources
This module features the following components to be provisioned with different combinations:

- AWS Organization [[aws_organizations_organization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization)]
- AWS Organization Unit [[aws_organizations_organizational_unit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit)]
- AWS Organization Policy [[aws_organizations_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy)]
- AWS Organization Member Account [[aws_organizations_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account)]
- Account Password Management Policy [[aws_iam_account_password_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy)]
- IAM Policy [[aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)]
    - MFA Enforcement Policy
    - Policies to allow different permissions
    - Policies to allow assuming the Cross Account roles
- IAM Role [[aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)]
- IAM Group [[aws_iam_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group)]
- IAM user [[aws_iam_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user)]
- IAM User: Login profile [[aws_iam_user_login_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_login_profile)]
- IAM User: Access key [[aws_iam_access_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key)]
- IAM User: SSH Key [[aws_iam_user_ssh_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_ssh_key)]
- Associate IAM users to IAM Groups [[aws_iam_user_group_membership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership)]
- Attachment of IAM Policy to IAM Group [[aws_iam_group_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment)]
- Attachment of IAM Policy with IAM role [[aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)]


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.22.0 |

## Examples

Refer [Configuration Examples](https://github.com/arjstack/terraform-aws-examples/tree/main/aws-iam) for effectively utilizing this module.

## Inputs

#### Organization Specific Properties
---

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|

## Outputs
| Name | Type | Description |
|:------|:------|:------|
| <a name="signin_url"></a> [signin_url](#output\_signin\_url) | `string` | SignIn URL based on alias |
| <a name="organization"></a> [organization](#output\_organization) | `map` | Organization Attributes -<br><b>id:</b> Identifier of the organization<br><b>arn:</b> ARN of the organization<br><b>master_account_id:</b> Identifier of the master account<br><b>master_account_arn:</b> ARN of the master account<br><b>master_account_email:</b> Email address of the master account<br><b>accounts:</b> List of organization accounts including the master account where each element will have id, name, arn, email and status of the account. <br><b>non_master_accounts:</b> List of organization accounts excluding the master account  where each element will have id, name, arn, email and status of the account. |
| <a name="organizations_accounts"></a> [organization_accounts](#output\_organization\_accounts) | `map` | Map of all the Organization accounts that are created as a member of the organization where each Key Pair will have the following combinations:<br><b>Map Key:</b> Friendly name for the member account.<br><b>Map Value:</b> Map of the following Account attributes:<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;id:</b> The AWS account id<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arn:</b> The ARN for this account |
| <a name="organizations_units"></a> [organizations_units](#output\_organizations\_units) | `map` | Map of all the Organization Units where each Key Pair will have the following combinations:<br><b>Map Key:</b> The name for the organizational unit.<br><b>Map Value:</b> Map of the following OU attributes:<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;id:</b> Identifier of the organization unit<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arn:</b> ARN of the organizational unit |
| <a name="force_mfa_policy_arn"></a> [force_mfa_policy_arn](#output\_force_\mfa\_policy\_arn) | `string` | ARN of the MFA enforcement policy, only if `create_force_mfa_policy` is set true |
| <a name="policies"></a> [policies](#output\_policies) | `map` | Map of all the IAM Policies where each Key Pair will have the following combinations:<br><b>Map Key:</b> The name of the policy.<br><b>Map Value:</b> Map of the following Policy attributes:<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;id:</b> The policy's ID<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arn:</b> The ARN assigned by AWS to this policy |
| <a name="roles"></a> [roles](#output\_roles) | `map` | Map of all the IAM Roles where each Key Pair will have the following combinations:<br><b>Map Key:</b> Friendly name of the IAM role<br><b>Map Value:</b> Map of the following Role attributes:<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arn:</b> The ARN assigned by AWS to this role<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;unique_id:</b> Stable and unique string identifying the role<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;create_date:</b> Creation date of the IAM role.<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;policies:</b> The List of Policy ARNs associated with the role |
| <a name="groups"></a> [groups](#output\_groups) | `map` | Map of all the IAM Groups where each Key Pair will have the following combinations:<br><b>Map Key:</b> The group's name<br><b>Map Value:</b> Map of the following Group attributes:<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;id:</b> The group's ID<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arn:</b> The ARN assigned by AWS for this group.<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;policies:</b> The List of Policy ARNs associated with the group<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;assumable_roles_policy:</b> The List of Policy ARNs associated with the group, to allow assuming the Cross Account role |
| <a name="users"></a> [users](#output\_users) | `map` | Map of all the IAM users where each Key Pair will have the following combinations:<br><b>Map Key:</b> The group's name<br><b>Map Value:</b> Map of the following User attributes:<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arn:</b> The ARN assigned by AWS for this user.<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;unique_id:</b> The unique ID assigned by AWS.<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;login_profile_key_fingerprint:</b> The fingerprint of the PGP key used to encrypt the password.<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;login_profile_encrypted_password:</b> The encrypted password, base64 encoded.<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;login_profile_password:</b> The plain text password, only available when pgp_key is not provided [applied sensitivity].<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;access_key_id:</b> Access key ID<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;access_key_secret:</b> Secret access key [applied sensitivity]<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;password_decrypt_command:</b> Command to decrypt the encrpted password<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;secret_key_decrypt_command:</b> Command to decrypt the encrpted secret<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;groups:</b> List of groups which user has a membership to. |


## Authors

Module is maintained by [Ankit Jain](https://github.com/ankit-jn) with help from [these professional](https://github.com/arjstack/terraform-aws-iam/graphs/contributors).
