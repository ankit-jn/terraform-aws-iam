variable "account_alias" {
    description = "(Required) The account alias"
    type        = string
}

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

variable "policies" {
    description = "List of Policies to create"
    type = list
    default = []
} 


variable "groups" {
    description = "List IAM Group to be created along with policies to be assigned"
    type        = list
    default     = []
}

variable "users" {
    description = "List of Users to create"
    type = list
    default = []
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

variable "create_force_mfa_policy" {
    description = "ARN of FOrce MFA policy"
    type        = bool
    default     = true
}