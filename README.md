# ARJ-Stack: AWS IAM Terraform module

A Terraform module for configuring IAM (Organization, Groups, Users, Polices, Roles etc.) in AWS.

---
## Features
- Organization
    - Create Account as AWS Organization
    - Create Organization Units (Support upto 5 Level through this module)
    - Apply Organization policies
    - Support for Creating Member Accounts of the organization
- Management of IAM Groups, Users
- Create Roles and Polcies and attach to IAM Groups
- Enforce User to setup MFA

Module supports 3 different typs of scenarios: 
- Organization: AWS Root Account, It can create member AWS account 
- Management Account: To manage IAM Groups, users, Policies
- Standard Account: To manage the applications 
    - Can create cross account roles so that Users in Management account can assume the roles
    - Set trust policy to Management account

Note: 
- The module can work even if Organization structure is not there. In that case everything will be provisioned in the same AWS account (of course, no need of Cross account role features to be managed then)
- The Organization and Management account can be clubed as well (though not a ideal practice)

Refer example section for different scenarios

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
| <a name="identity_account"></a> [identity_account](#input\_identity\_account) | Whether account is for Identity management [i.e. User, Group, Role Management] (could be a part of AWS organization)? | `boolean` | `false` | no |  |
| <a name="aws_service_access_principals"></a> [aws_service_access_principals](#input\_aws\_service\_access\_principals) | List of AWS service principal names for which you want to enable integration with your organization. | `list(string)` | `[]` | no | <pre>[<br>   "cloudtrail.amazonaws.com",<br>   "config.amazonaws.com",<br>   "account.amazonaws.com"<br>]<pre> |
| <a name="enabled_policy_types"></a> [enabled_policy_types](#input\_enabled\_policy\_types) | List of Organizations policy types to enable in the Organization Root.<br><b>Valid policy types:</b><br>1. AISERVICES_OPT_OUT_POLICY<br>2. BACKUP_POLICY<br>3. SERVICE_CONTROL_POLICY<br>4. TAG_POLICY | `list(string)` | `[]` | no | <pre>["SERVICE_CONTROL_POLICY"]<pre> |
| <a name="feature_set"></a> [feature_set](#input\_feature\_set) | The organization features to use. <b>Valid Value:</b><br>1. ALL<br>2. CONSOLIDATED_BILLING | `string` | `"ALL"` | no |  |
| <a name="organization_units"></a> [organization_units](#organization_units) | List of Map of Organization Units | `map` | `list(map)` | no | <pre>[<br>   {<br>     name = "R&D"<br>   },<br>   {<br>     name = "Dev"<br>     parent = "R&D"<br>   }<br>]<pre> |
| <a name="organizations_policies"></a> [organizations_policies](#organizations\_policies) | List of Map for organizations Policies | `list(map)` | `[]` | no | <pre>[<br>   {<br>     name = "my-first-scp"<br>     description = "My First SCP"<br>     type = "SERVICE_CONTROL_POLICY"<br>     tags = {<br>       "name"="terraform training"<br>     }<br>   },<br>   {<br>     name = "my-second-scp"<br>     description = "My second SCP"<br>     type = "SERVICE_CONTROL_POLICY"<br>     }<br>]<pre> |
| <a name="organizations_accounts"></a> [organizations_accounts](#organizations\_accounts) | List of Map for member accounts to be created in the current organization | `list(map)` | `[]` | no | <pre>[<br>   {<br>     name = "terraform-training"<br>     email = "xxxx@xxxx.com"<br>     role_name = "owner"<br>     tags = {<br>       "name"="arj-development"<br>     }<br>   },<br>   {<br>     name = "arj-training"<br>     email = "zzzz@zzzz.com"<br>     role_name = "OWNER"<br>     }<br>]<pre> |

#### Management Account Specific properties
---

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="manage_account_password_policy"></a> [manage_account_password_policy](#input\_manage\_account\_password\_policy) | Flag to decide if Account Password Management Policy should be applied | `bool` | `true` | no |  |
| <a name="password_policy"></a> [password_policy](#password\_policy) | Password Policy Management rules | `map(string)` | `{}` | no |  |
| <a name="create_force_mfa_policy"></a> [create_force_mfa_policy](#input\_create\_force\_mfa\_policy) | Flag to decide if MFA enforcement policy should be created | `bool` | `true` | no |  |

#### IAM resources [Policy, Role, Group, Users] Specific properties
---

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="policies"></a> [policies](#policy) | List of IAM Policies configuration Map | `map` | `[]` | no | <pre>[<br>   {<br>     name = "arjstack-support-access"<br>     description = "Full Stack Development policy"<br>     path = "/"<br>   },<br>   {<br>     name = "dashboard-policy"<br>     description = "Dashboard policy"<br>     path = "/"<br>   }<br>]<pre> |
| <a name="trusted_account_roles"></a> [trusted_account_roles](#role) | List of IAM Roles configuration Map | `map` | `[]` | no | <pre>[<br>   {<br>     name = "ARJCrossAccountDevOpsRole"<br>     description = "ARJ Cross Account Devops Role"<br>     path = "/"<br>     account_ids = [<br>        "12 digit account id-1",<br>        "12 digit account id-2",<br>        .....<br>     ]<br>     policy_map = {<br>       policy_names = [<br>          "arjstack-ci-cd-service-access"<br>       ]<br>       policy_arns = [<br>          "arn:aws:iam::aws:policy/AmazonDevOpsGuruReadOnlyAccess",<br>       ]<br>     }<br>     tags = {"Purpose" = "DevOps"}<br>   },<br>]<br><pre> |
| <a name="service_linked_roles"></a> [service_linked_roles](#role) | List of IAM Roles configuration Map | `map` | `[]` | no | <pre>[<br>   {<br>     name = "ARJS3SupportRole"<br>     description = "ARJ Cross Account Support Role"<br>     path = "/"<br>     service_names = [<br>        "ecs.amazonaws.com",<br>        "ec2.amazonaws.com"<br>        .....<br>     ]<br>     policy_map = {<br>       policy_names = [<br>          "arjstack-s3-readonly-access"<br>       ]<br>       policy_arns = [<br>          "arn:aws:iam::aws:policy/AWSCloudTrail_ReadOnlyAccess",<br>       ]<br>     }<br>     tags = {"Purpose" = "Support"}<br>   },<br>]<br><pre> |
| <a name="groups"></a> [groups](#group) | List of IAM Groups configuration Map | `map` | `[]` | no | <pre>[<br>   {<br>     name = "Leaders"<br>     policy_map = {<br>       policy_names = [<br>          "full-stack-development-policy"<br>       ]<br>       policy_arns = [<br>          "arn:aws:iam::aws:policy/AdministratorAccess",<br>       ]<br>     }<br>     assumable_roles = ["arn:aws:iam::xxxxxxxxxxxx:role/cross-account-read-only-role1",]<br>   },<br>]<br><pre> |
| <a name="users"></a> [users](#user) | List of IAM Users configuration Map | `map` | `[]` | no | <pre>[<br>   {<br>     name = "A.Jain"<br>     create_login_profile = "yes"<br>     create_access_key = "yes"<br>     force_destroy = "no"<br>     upload_ssh_key = "yes"<br>     ssh_public_key = "<ssh rsa public key>"<br>     force_mfa = "no"<br>     groups = "Leaders,Administrators"<br>   },<br>]<br><pre> |


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
&nbsp;&nbsp;&nbsp;- JSON document must be placed in the directory `org_policies` under root directory.<br>
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

#### password_policy

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="allow_users_to_change_password"></a> [allow_users_to_change_password](#input\_allow\_users\_to\_change\_password) | Whether to allow users to change their own password | `string` | `yes` | no |  |
| <a name="hard_expiry"></a> [hard_expiry](#input\_hard\_expiry) | Whether users are prevented from setting a new password after their password has expired | `string` | `no` | no |  |
| <a name="max_password_age"></a> [max_password_age](#input\_max\_password\_age) | The number of days that an user password is valid. | `number` | `0` | no |  |
| <a name="minimum_password_length"></a> [minimum_password_length](#input\_minimum\_password\_length) | Minimum length to require for user passwords. | `number` | `8` | no |  |
| <a name="password_reuse_prevention"></a> [password_reuse_prevention](#input\_password\_reuse\_prevention) | The number of previous passwords that users are prevented from reusing. | `string` |  | no |  |
| <a name="require_lowercase_characters"></a> [require_lowercase_characters](#input\_require\_lowercase\_characters) | Whether to require lowercase characters for user passwords. | `string` | `yes` | no |  |
| <a name="require_numbers"></a> [require_numbers](#input\_require\_numbers) | Whether to require numbers for user passwords. | `string` | `yes` | no |  |
| <a name="require_symbols"></a> [require_symbols](#input\_require\_symbols) | Whether to require symbols for user passwords. | `string` | `yes` | no |  |
| <a name="require_uppercase_characters"></a> [require_uppercase_characters](#input\_require\_uppercase\_characters) | Whether to require uppercase characters for user passwords | `string` | `yes` | no |  |

#### policy

Policy content to be add to the new policy will be read from the JSON document.<br>
&nbsp;&nbsp;&nbsp;- JSON document must be placed in the directory `policies` under root directory.<br>
&nbsp;&nbsp;&nbsp;- The naming format of the file: <Value set in `name` property>.json

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="name"></a> [name](#input\_name) | The name of the policy. | `string` | `yes` | yes |  |
| <a name="description"></a> [description](#input\_description) | Description of the IAM policy. | `string` | `<name of the policy>` | no |  |
| <a name="path"></a> [path](#input\_path) | Path in which to create the policy. | `string` | `"/"` | no |  |
| <a name="tags"></a> [tags](#input\_tags) | A map of tags to assign to the policy. | `{}` | `no` | no |  |

#### role

- Property `account_ids` is used only for `trusted_account_roles`
- Property `service_names` is used only for `service_linked_roles`

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="name"></a> [name](#input\_name) | Friendly name of the IAM role.  | `string` |  | yes |  |
| <a name="description"></a> [description](#input\_description) | Description of the IAM role. | `string` | `<name of the role>` | no |  |
| <a name="path"></a> [path](#input\_path) | Path in which to create the policy. | `string` | `"/"` | no |  |
| <a name="max_session_duration"></a> [max_session_duration](#input\_max\_session\_duration) | Path in which to create the role. | `number` | `3600` | no |  |
| <a name="force_detach_policies"></a> [force_detach_policies](#input\_force\_detach\_policies) | Whether to force detaching any policies the role has before destroying it. | `bool` | `false` | no |  |
| <a name="account_ids"></a> [account_ids](#input\_account\_ids) | List of Account IDs to be trusted | `list(string)` |  | yes | Required in case of `trusted_account_roles` |
| <a name="service_names"></a> [service_names](#input\_service\_names) | List of Service domain to be trusted | `list(string)` |  | yes | Required in case of `service_linked_roles` |
| <a name="policy_map"></a> [policy_map](#input\_policies) | The Map of 2 different type of Policies to be attached to this role where,<br><b>Map Key:</b> Policy Type [There could be 2 different values : `policy_names`, `policy_arns`]<br><b>Map Value:</b> A List of Policies as stated below:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. policy_names: List of Policy which will be provisioned as part of IAC defined in property `policies`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. policy_arns: List of ARN of the policies which are provisioned out of this IAC | `map` | `{}` | no |  |
| <a name="tags"></a> [tags](#input\_tags) | A map of tags to assign to the policy. | `{}` | `no` | no |  |

#### group

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="name"></a> [name](#input\_name) | The name of the group. | `string` | `yes` | yes |  |
| <a name="path"></a> [path](#input\_path) | Path in which to create the group. | `string` | `"/"` | no |  |
| <a name="policy_map"></a> [policy_map](#input\_policies) | The Map of 2 different type of Policies to be attached to this group where,<br><b>Map Key:</b> Policy Type [There could be 2 different values : `policy_names`, `policy_arns`]<br><b>Map Value:</b> A List of Policies as stated below:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. policy_names: List of Policy which will be provisioned as part of IAC defined in property `policies`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. policy_arns: List of ARN of the policies which are provisioned out of this IAC | `map` | `{}` | no |  |
| <a name="assumable_roles"></a> [assumable_roles](#input\_assumable\_roles) | The list of ARNs of the Cross Account Role which can be assumed by the IAM principals part of this group. | `list(string)` | `[]` | no |  |

#### user

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="name"></a> [name](#input\_name) | The user's name. | `string` |  | yes |  |
| <a name="path"></a> [path](#input\_path) | Path in which to create the group. | `string` | `"/"` | no |  |
| <a name="force_destroy"></a> [force_destroy](#input\_force\_destroy) | hen destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. | `string` | `"yes"` | no |  |
| <a name="permissions_boundary"></a> [permissions_boundary](#input\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the user. | `string` |  | no |  |
| <a name="create_login_profile"></a> [create_login_profile](#input\_create\_login\_profile) | Manages an IAM User Login Profile | `string` | `"no"` | no |  |
| <a name="pgp_key_file"></a> [pgp_key_file](#input\_pgp\_key\_file) | A base-64 encoded PGP public key file name: Has to be stored in folder "/keys/pgp/" at the root  | `string` |  | no |  |
| <a name="password_length"></a> [password_length](#input\_password\_length) | The length of the generated password on resource creation. | `number` | `32` | no |  |
| <a name="password_reset_required"></a> [password_reset_required](#input\_password\_reset\_required) | Whether the user should be forced to reset the generated password on resource creation. | `string` | `"yes"` | no |  |
| <a name="create_access_key"></a> [create_access_key](#input\_create\_access\_key) | Provides an IAM access key. | `string` | `"no"` | no |  |
| <a name="access_key_status"></a> [access_key_status](#input\_access\_key\_status) | Access key status to apply | `string` | `"Active"` | no |  |
| <a name="upload_ssh_key"></a> [upload_ssh_key](#input\_upload\_ssh\_key) | Whether to upload SSH public key | `string` | `"no"` | no |  |
| <a name="encoding"></a> [encoding](#input\_encoding) | Specifies the public key encoding format to use in the response. | `string` | `"SSH"` | no |  |
| <a name="ssh_public_key_file"></a> [ssh_public_key_file](#input\_ssh\_public\_key\_file) | SSH Public Key file name (Encoded SSH public key in ssh-rsa format): Has to be stored in folder "/keys/ssh/" at the root. | `string` |  | no |  |
| <a name="ssh_key_status"></a> [ssh_key_status](#input\_ssh\_key\_status) | The status to assign to the SSH public key. | `string` | `"Active"` | no |  |
| <a name="force_mfa"></a> [force_mfa](#input\_force\_mfa) | Whether to enforce IAM user for MFA | `string` | `"yes"` | no |  |
| <a name="groups"></a> [groups](#input\_groups) | Comma separated value of the IAM groups | `string` |  | no |  |

## Outputs

| Name | Type | Description |
|:------|:------|:------|
| <a name="signin_url"></a> [signin_url](#output\_signin\_url) | `string` | SignIn URL based on alias |
| <a name="organization"></a> [organization](#output\_organization) | `map` | Organization Attributes -<br>`id:` Identifier of the organization<br>`arn:` ARN of the organization<br>`master_account_id:` Identifier of the master account<br>`master_account_arn:` ARN of the master account<br>`master_account_email:` Email address of the master account<br>`accounts:` List of organization accounts including the master account where each element will have id, name, arn, email and status of the account. <br>`non_master_accounts:` List of organization accounts excluding the master account  where each element will have id, name, arn, email and status of the account. |
| <a name="organizations_accounts"></a> [organization_accounts](#output\_organization\_accounts) | `map` | Map of all the Organization accounts that are created as a member of the organization where each Key Pair will have the following combinations:<br><b>Map Key:</b> Friendly name for the member account.<br><b>Map Value:</b> Map of the following Account attributes:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`id:` The AWS account id<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`arn:` The ARN for this account |
| <a name="organizations_units"></a> [organizations_units](#output\_organizations\_units) | `map` | Map of all the Organization Units where each Key Pair will have the following combinations:<br><b>Map Key:</b> The name for the organizational unit.<br><b>Map Value:</b> Map of the following OU attributes:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`id:` Identifier of the organization unit<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`arn:` ARN of the organizational unit |
| <a name="force_mfa_policy_arn"></a> [force_mfa_policy_arn](#output\_force_\mfa\_policy\_arn) | `string` | ARN of the MFA enforcement policy, only if `create_force_mfa_policy` is set true |
| <a name="policies"></a> [policies](#output\_policies) | `map` | Map of all the IAM Policies where each Key Pair will have the following combinations:<br><b>Map Key:</b> The name of the policy.<br><b>Map Value:</b> Map of the following Policy attributes:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`id:` The policy's ID<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`arn:` The ARN assigned by AWS to this policy |
| <a name="trusted_account_roles"></a> [trusted_account_roles](#output\_trusted\_account\_roles) | `map` | Map of AWS account trust based IAM Roles where each Key Pair will have the following combinations:<br><b>Map Key:</b> Friendly name of the IAM role<br><b>Map Value:</b> Map of the following Role attributes:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`arn:` The ARN assigned by AWS to this role<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`unique_id:` Stable and unique string identifying the role<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`create_date:` Creation date of the IAM role.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`policies:` The List of Policy ARNs associated with the role |
| <a name="service_linked_roles"></a> [service_linked_roles](#output\_service\_linked\_roles) | `map` | Map of AWS Service linked IAM Roles where each Key Pair will have the following combinations:<br><b>Map Key:</b> Friendly name of the IAM role<br><b>Map Value:</b> Map of the following Role attributes:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`arn:` The ARN assigned by AWS to this role<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`unique_id:` Stable and unique string identifying the role<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`create_date:` Creation date of the IAM role.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`policies:` The List of Policy ARNs associated with the role |
| <a name="groups"></a> [groups](#output\_groups) | `map` | Map of all the IAM Groups where each Key Pair will have the following combinations:<br><b>Map Key:</b> The group's name<br><b>Map Value:</b> Map of the following Group attributes:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`id:` The group's ID<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`arn:` The ARN assigned by AWS for this group.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`policies:` The List of Policy ARNs associated with the group<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`assumable_roles_policy:` The List of Policy ARNs associated with the group, to allow assuming the Cross Account role |
| <a name="users"></a> [users](#output\_users) | `map` | Map of all the IAM users where each Key Pair will have the following combinations:<br><b>Map Key:</b> The group's name<br><b>Map Value:</b> Map of the following User attributes:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`arn:` The ARN assigned by AWS for this user.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`unique_id:` The unique ID assigned by AWS.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`login_profile_key_fingerprint:` The fingerprint of the PGP key used to encrypt the password.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`login_profile_encrypted_password:` The encrypted password, base64 encoded.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`login_profile_password:` The plain text password, only available when pgp_key is not provided [applied sensitivity].<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`access_key_id:` Access key ID<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`access_key_secret:` Secret access key [applied sensitivity]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`password_decrypt_command:` Command to decrypt the encrpted password<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`secret_key_decrypt_command:` Command to decrypt the encrpted secret<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`groups:` List of groups which user has a membership to. |


## Authors

Module is maintained by [Ankit Jain](https://github.com/ankit-jn) with help from [these professional](https://github.com/arjstack/terraform-aws-iam/graphs/contributors).
