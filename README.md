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
| <a name="account_alias"></a> [account_alias](#input\_account\_alias) | The account alias | `string` |  | no |  |
| <a name="organization_account"></a> [organization_account](#input\_organization\_account) | Whether account is AWS organiations? | `boolean` | `false` | no |  |
| <a name="management_account"></a> [management_account](#input\_management\_account) | Whether account is for management [i.e. user, group, Policy Management] (could be a part of AWS organization)? | `boolean` | `false` | no |  |
| <a name="aws_service_access_principals"></a> [aws_service_access_principals](#input\_aws\_service\_access\_principals) | List of AWS service principal names for which you want to enable integration with your organization. | `list(string)` | `[]` | no | <pre>[<br>   "cloudtrail.amazonaws.com",<br>   "config.amazonaws.com",<br>   "account.amazonaws.com"<br>]<pre> |
| <a name="enabled_policy_types"></a> [enabled_policy_types](#input\_enabled\_policy\_types) | List of Organizations policy types to enable in the Organization Root.<br><b>Valid policy types:</b><br>1. AISERVICES_OPT_OUT_POLICY<br>2. BACKUP_POLICY<br>3. SERVICE_CONTROL_POLICY<br>4. TAG_POLICY | `list(string)` | `[]` | no | <pre>["SERVICE_CONTROL_POLICY"]<pre> |
| <a name="feature_set"></a> [feature_set](#input\_feature\_set) | The organization features to use. <b>Valid Value:</b><br>1. ALL<br>2. CONSOLIDATED_BILLING | `string` | `"ALL"` | no |  |
| <a name="organization_units"></a> [organization_units](#organization_units) | List of Map of Organization Units | `map` | `list(map)` | no | <pre>[<br>   {<br>     name = "R&D"<br>   },<br>   {<br>     name = "Dev"<br>     parent = "R&D"<br>   }<br>]<pre> |
| <a name="organizations_policies"></a> [organizations_policies](#organizations\_policies) | List of Map for organizations Policies | `list(map)` | `[]` | no | <pre>[<br>   {<br>     name = "my-first-scp"<br>     description = "My First SCP"<br>     type = "SERVICE_CONTROL_POLICY"<br>     tags = {<br>       "name"="terraform training"<br>     }<br>   },<br>   {<br>     name = "my-second-scp"<br>     description = "My second SCP"<br>     type = "SERVICE_CONTROL_POLICY"<br>     }<br>]<pre> |
| <a name="organizations_accounts"></a> [organizations_accounts](#organizations\_accounts) | List of Map for member accounts to be created in the current organization | `list(map)` | `[]` | no | <pre>[<br>   {<br>     name = "terraform-training"<br>     email = "xxxx@xxxx.com"<br>     role_name = "owner"<br>     tags = {<br>       "name"="arj-development"<br>     }<br>   },<br>   {<br>     name = "arj-training"<br>     email = "zzzz@zzzz.com"<br>     role_name = "OWNER"<br>     }<br>]<pre> |

#### TAG Specific properties
---
| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="organization_default_tags"></a> [organization_default_tags](#input\_organization\_default\_tags) | A map of tags to assign to all Organizational Resources. | `map` | `{}` | no | |
| <a name="role_default_tags"></a> [role_default_tags](#input\_role\_default\_tags) | A map of tags to assign to all Roles. | `map` | `{}` | no | |
| <a name="policy_default_tags"></a> [policy_default_tags](#input\_policy\_default\_tags) | A map of tags to assign to all Policies. | `map` | `{}` | no | |
| <a name="users_default_tags"></a> [users_default_tags](#input\_users\_default\_tags) | A map of tags to assign to all Users. | `map` | `{}` | no | |

## Nested Configuration Maps:  

#### organization_units

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="name"></a> [name](#input\_name) | The name for the organizational unit | `string` |  | yes |  |
| <a name="parent"></a> [parent](#input\_parent) | The name the parent organizational unit; If not given; Root will be the parent | `string` |  | no |  |
| <a name="tags"></a> [tags](#input\_tags) | A map of tags to assign to the OU resource. | `map` | `{}` | no |  |

#### organizations_policies

Policy content to be add to the new policy will be read from the JSON document.<br>
&nbsp;&nbsp;&nbsp;- JSON document must be placed in the directory "org_policies" under root directory.<br>
&nbsp;&nbsp;&nbsp;- The naming format of the file: <Value set in `name` property>.json

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="name"></a> [name](#input\_name) | The friendly name to assign to the policy. | `string` |  | yes |  |
| <a name="description"></a> [description](#input\_account\_alias) | A description to assign to the policy. | `string` | `"SERVICE_CONTROL_POLICY"` | no |  |
| <a name="type"></a> [type](#input\_type) | The account alias | `string` |  | no |  |
| <a name="tags"></a> [tags](#input\_tags) | A map of tags to assign to the Organization Policy | `map` | `{}` | no |  |

#### organizations_accounts

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="name"></a> [name](#input\_name) | Friendly name for the member account. | `string` |  | yes |  |
| <a name="email"></a> [email](#input\_email) | Email address of the owner to assign to the new member account. | `string` |  | yes |  |
| <a name="role_name"></a> [role_name](#input\_role\_name) | The name of an IAM role that Organizations automatically preconfigures in the new member account. | `string` |  | yes |  |
| <a name="tags"></a> [tags](#input\_tags) | A map of tags to assign to the member account | `map` | `{}` | no |  |

## Outputs
| Name | Type | Description |
|:------|:------|:------|
| <a name="signin_url"></a> [signin_url](#output\_signin\_url) | `string` | SignIn URL based on alias |
| <a name="organization"></a> [organization](#output\_organization) | `map` | Organization Attributes -<br>`id:` Identifier of the organization<br>`arn:` ARN of the organization<br>`master_account_id:` Identifier of the master account<br>`master_account_arn:` ARN of the master account<br>`master_account_email:` Email address of the master account<br>`accounts:` List of organization accounts including the master account where each element will have id, name, arn, email and status of the account. <br>`non_master_accounts:` List of organization accounts excluding the master account  where each element will have id, name, arn, email and status of the account. |
| <a name="organizations_accounts"></a> [organization_accounts](#output\_organization\_accounts) | `map` | Map of all the Organization accounts that are created as a member of the organization where each Key Pair will have the following combinations:<br><b>Map Key:</b> Friendly name for the member account.<br><b>Map Value:</b> Map of the following Account attributes:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`id:` The AWS account id<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`arn:` The ARN for this account |
| <a name="organizations_units"></a> [organizations_units](#output\_organizations\_units) | `map` | Map of all the Organization Units where each Key Pair will have the following combinations:<br><b>Map Key:</b> The name for the organizational unit.<br><b>Map Value:</b> Map of the following OU attributes:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`id:` Identifier of the organization unit<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`arn:` ARN of the organizational unit |
| <a name="force_mfa_policy_arn"></a> [force_mfa_policy_arn](#output\_force_\mfa\_policy\_arn) | `string` | ARN of the MFA enforcement policy, only if `create_force_mfa_policy` is set true |
| <a name="policies"></a> [policies](#output\_policies) | `map` | Map of all the IAM Policies where each Key Pair will have the following combinations:<br><b>Map Key:</b> The name of the policy.<br><b>Map Value:</b> Map of the following Policy attributes:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`id:` The policy's ID<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`arn:` The ARN assigned by AWS to this policy |
| <a name="roles"></a> [roles](#output\_roles) | `map` | Map of all the IAM Roles where each Key Pair will have the following combinations:<br><b>Map Key:</b> Friendly name of the IAM role<br><b>Map Value:</b> Map of the following Role attributes:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`arn:` The ARN assigned by AWS to this role<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`unique_id:` Stable and unique string identifying the role<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`create_date:` Creation date of the IAM role.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`policies:` The List of Policy ARNs associated with the role |
| <a name="groups"></a> [groups](#output\_groups) | `map` | Map of all the IAM Groups where each Key Pair will have the following combinations:<br><b>Map Key:</b> The group's name<br><b>Map Value:</b> Map of the following Group attributes:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`id:` The group's ID<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`arn:` The ARN assigned by AWS for this group.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`policies:` The List of Policy ARNs associated with the group<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`assumable_roles_policy:` The List of Policy ARNs associated with the group, to allow assuming the Cross Account role |
| <a name="users"></a> [users](#output\_users) | `map` | Map of all the IAM users where each Key Pair will have the following combinations:<br><b>Map Key:</b> The group's name<br><b>Map Value:</b> Map of the following User attributes:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`arn:` The ARN assigned by AWS for this user.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`unique_id:` The unique ID assigned by AWS.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`login_profile_key_fingerprint:` The fingerprint of the PGP key used to encrypt the password.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`login_profile_encrypted_password:` The encrypted password, base64 encoded.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`login_profile_password:` The plain text password, only available when pgp_key is not provided [applied sensitivity].<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`access_key_id:` Access key ID<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`access_key_secret:` Secret access key [applied sensitivity]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`password_decrypt_command:` Command to decrypt the encrpted password<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`secret_key_decrypt_command:` Command to decrypt the encrpted secret<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`groups:` List of groups which user has a membership to. |


## Authors

Module is maintained by [Ankit Jain](https://github.com/ankit-jn) with help from [these professional](https://github.com/arjstack/terraform-aws-iam/graphs/contributors).
