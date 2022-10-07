variable "account_alias" {
    description = "(Optional) The account alias"
    type        = string
    default     = ""
}

variable "organization_account" {
    description = "Whether account is AWS organiations?"
    type = bool
    default = false
}

variable "management_account" {
    description = "Whether account is for management [i.e. user, group, Policy Management] (could be a part of AWS organization)?"
    type = bool
    default = false
}

## Organization Account Specific Variables
variable aws_service_access_principals {
    description = "description"
    default     = []
}

variable enabled_policy_types {
    description = "List of Organizations Policy Types to enable in the Organization Root"
    default     = []
}

variable feature_set {
    description = ""
    type        = string
    default     = "ALL"
}

variable organization_units {
    description = ""
    default     = []
}

variable "organizations_policies" {
    description = "List of Policies to create"
    default = []
} 

variable "organizations_accounts" {
    description = "List of Organization Accounts"
    type = list(object({
                    name      = string
                    email     = string
                    role_name = string
                    tags = map(string)
                }))
    default = []
} 


## Management Account Specific Variables

variable "manage_account_password_policy" {
    description = "Flag to decide if manage account Password Policy"
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
    description = "ARN of FOrce MFA policy"
    type        = bool
    default     = true
}

variable "policies" {
    description = "List of Policies to create"
    default = []
} 

variable "roles" {
    description = "List of Roles to create"
    default = []
} 

variable "trust_account_ids" {
    description = "Default Comma separated Account IDs to be trusted in case of Cross Account roles"
    type        = string
    default     = ""
}

variable "groups" {
    description = "List IAM Group to be created along with policies to be assigned"
    default     = []
}

variable "users" {
    description = "List of Users to create"
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
