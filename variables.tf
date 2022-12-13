variable "account_alias" {
    description = "(Required) The account alias"
    type        = string
    default     = ""
}

variable "organization_account" {
    description = "Whether account is AWS organiations?"
    type = bool
    default = false
}

variable "identity_account" {
    description = "Whether account is for identity management [i.e. user, group, Policy Management] (could be a part of AWS organization)?"
    type = bool
    default = false
}

## Organization Account Specific Variables
variable aws_service_access_principals {
    description = <<EOF
(Optional) List of AWS service principal names for which you want 
to enable integration with your organization.
EOF
    default     = []
}

variable enabled_policy_types {
    description = <<EOF
(Optional) List of Organizations policy types to enable in the Organization Root.
Valid policy types: AISERVICES_OPT_OUT_POLICY, BACKUP_POLICY, SERVICE_CONTROL_POLICY, TAG_POLICY
EOF
    default     = []
}

variable feature_set {
    description = "(Optional) Specify \"ALL\" (default) or \"CONSOLIDATED_BILLING\"."
    type        = string
    default     = "ALL"
}

variable organization_units {
    description = <<EOF
(Optional) List of Map for Organization Units witht the following Key Pairs:

name - The name for the organizational unit
parent - (Optional) The name the parent organizational unit; If not given; Root will be the parent
tags - (Optional) A map of tags to assign to the OU resource.

Note: OU hierarchy upto Level 5 is supported in this codebase
EOF
    default     = []
}

variable "organizations_policies" {
    description = <<EOF
(Optional) List of Map for organizations Policies with the follwoing Key Pairs:
One of the variable is required: `policy_file` or `policy_content`

name - (Required) The friendly name to assign to the policy.
policy_file - (Optional) Policy File name with path relative to root directory.
policy_content - (Optional) Policy Content (JSON).
description - (Optional) A description to assign to the policy.
type -  (Optional) The type of policy to create. 
        Valid values are AISERVICES_OPT_OUT_POLICY, BACKUP_POLICY, SERVICE_CONTROL_POLICY (SCP), and TAG_POLICY.
        Default: SERVICE_CONTROL_POLICY
tags - (Optional) A map of tags to assign to the policy.

Note: Policy content to be add to the new policy will be read from the JSON document 
      JSON document must be placed in the directory "org_policies" under root directory. 
      The naming format of the file: <Value set in name property>.json
EOF
    default = []
} 

variable "organizations_accounts" {
    description = <<EOF
(Optional) List of Map for member accounts to be created in the current organization with the following Key pais:

name - (Required) Friendly name for the member account.
email - (Required) Email address of the owner to assign to the new member account.
role_name - (Optional) The name of an IAM role that Organizations automatically preconfigures in the new member account. 
access_to_billing - (Optional) If set to ALLOW, the new account enables IAM users and roles to access account billing 
                    information if they have the required permissions. Default - ALLOW
tags - (Optional) A map of tags to assign to the memeber Account resource.
EOF
    default = []
} 

## Management Account Specific Variables

variable "manage_account_password_policy" {
    description = "Flag to decide if Account Password Management Policy should be applied"
    type        = bool
    default     = true
}

variable "password_policy" {
    description = <<EOF
Password Policy Management rules:

allow_users_to_change_password - (Optional) Whether to allow users to change their own password
hard_expiry - (Optional) Whether users are prevented from setting a new password after their password has expired (i.e. require administrator reset)
max_password_age - (Optional) The number of days that an user password is valid.
minimum_password_length - (Optional) Minimum length to require for user passwords.
password_reuse_prevention - (Optional) The number of previous passwords that users are prevented from reusing.
require_lowercase_characters - (Optional) Whether to require lowercase characters for user passwords.
require_numbers - (Optional) Whether to require numbers for user passwords.
require_symbols - (Optional) Whether to require symbols for user passwords.
require_uppercase_characters - (Optional) Whether to require uppercase characters for user passwords

EOF
    type        = map(string)
    default = {}
}

variable "create_force_mfa_policy" {
    description = "Flag to decide if MFA enforcement policy should be created"
    type        = bool
    default     = true
}

variable "policies" {
    description = <<EOF
(Optional) List of Map for IAM Policies with the follwoing Key Pairs:
One of the variable is required: `policy_file` or `policy_content`

name - (Required) The name of the policy. 
policy_file: (Optional) Policy File name with path relative to root directory.
policy_content: (Optional) Policy Content (JSON).
description - (Optional) Description of the IAM policy. Default: Policy Name
path - (Optional, default "/") Path in which to create the policy.
tags - (Optional) A map of tags to assign to the policy.

Note: Policy content to be add to the new policy will be read from the JSON document 
      JSON document must be placed in the directory "policies" under root directory. 
      The naming format of the file: <Value set in name property>
EOF
    default = []
} 

variable "trusted_account_roles" {
    description = <<EOF
(Optional) List of Map for AWS Service linked IAM Roles with the follwoing Key Pairs:

name - (Required) Friendly name of the IAM role. 
description - (Optional, default role name) Description of the IAM Role. Default: Role Name
path - (Optional, default "/") Path in which to create the Role.
max_session_duration - (Optional, default 3600) Maximum session duration (in seconds) that you want to set for the specified role.
force_detach_policies - (Optional, default false) Whether to force detaching any policies the role has before destroying it.
account_ids - (Required) List of Account IDs to be trusted
tags - (Optional) A map of tags to assign to the policy.

policy_list - List of Policies to be attached where each entry will be map with following entries
    name - Policy Name
    arn - Policy ARN (if existing policy)
EOF
    default = []
} 

variable "service_linked_roles" {
    description = <<EOF
(Optional) List of Map for AWS service linked IAM Roles with the follwoing Key Pairs:

name - (Required) Friendly name of the IAM role. 
description - (Optional, default role name) Description of the IAM Role. Default: Role Name
path - (Optional, default "/") Path in which to create the Role.
max_session_duration - (Optional, default 3600) Maximum session duration (in seconds) that you want to set for the specified role.
force_detach_policies - (Optional, default false) Whether to force detaching any policies the role has before destroying it.
service_names - (Required) List of Service domain to be trusted 
tags - (Optional) A map of tags to assign to the policy.

policy_list - List of Policies to be attached where each entry will be map with following entries
    name - Policy Name
    arn - Policy ARN (if existing policy)
EOF
    default = []
}


variable "groups" {
    description = <<EOF
(Optional) List of Map for IAM Groups with the follwoing Key Pairs:

name - (Required) The group's name.
path - (Optional, default "/") Path in which to create the group.

policy_map - The Map of 2 different type of Policies which will be applied on Group, where 
Map key - Policy Type [There could be 2 different values : `policy_names`, `policy_arns`]<br>
Map Value - A List of Policies as stated below
            policy_names: List of Policy which will be provisioned as part of IAC 
            policy_arns: List of ARN of the policies which are provisioned out of this IAC
EOF
    default     = []
}

variable "users" {
    description = <<EOF
(Optional) List of Map for IAM Users with the follwoing Key Pairs:

name - (Required) The user's name.
path - (Optional, default "/") Path in which to create the group.
force_destroy - (Optional, default "yes") When destroying this user, destroy even if 
                it has non-Terraform-managed IAM access keys, login profile or MFA devices. 
permissions_boundary - (Optional) The ARN of the policy that is used to set the permissions 
                       boundary for the user.

create_login_profile - (Optional, default "no") Manages an IAM User Login Profile
pgp_key_file - (Optional, default "") A base-64 encoded PGP public key file name with path relative to root directory.
password_length - (Optional, default 32) The length of the generated password on resource creation.
password_reset_required - (Optional, default "yes") Whether the user should be forced 
                          to reset the generated password on resource creation.

create_access_key - (Optional, default "no") Provides an IAM access key.
access_key_status - (Optional, default "Active") Access key status to apply.

upload_ssh_key - (Optional, default "no") Whether to upload SSH public key
encoding - (Optional, default "SSH") Specifies the public key encoding format to use in the response.
ssh_public_key_file - (Optional, default "no") (Required) SSH Public Key file name with path relative to root directory. (Encoded SSH public key in ssh-rsa format)
ssh_key_status - (Optional, default "Active") (Optional) The status to assign to the SSH public key.

force_mfa - (Optional, default "yes") Whether to enforce IAM user for MFA
            Only applies when create_force_mfa_policy is true

groups - (Optional) Comma separated value of the IAM groups
EOF
    default = []
} 

### TAGS specific variables
variable "organization_default_tags" {
    description = "(Optional) A map of tags to assign to all Organizational Resources."
    type = map
    default = {}
}

variable "role_default_tags" {
    description = "(Optional) A map of tags to assign to all Roles."
    type = map
    default = {}
}

variable "policy_default_tags" {
    description = "(Optional) A map of tags to assign to all Policies."
    type = map
    default = {}
}

variable "users_default_tags" {
    description = "(Optional) A map of tags to assign to all Users."
    type = map
    default = {}
}
