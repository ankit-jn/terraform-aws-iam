variable "manage_account_password_policy" {
    description = "Flag to decide if Account Password Management Policy should be applied"
    type        = bool
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
}

variable "create_force_mfa_policy" {
    description = "Flag to decide if MFA enforcement policy should be created"
    type        = bool
    default     = true
}

variable "groups" {
    description = <<EOF
(Optional) List of Map for IAM Groups with the follwoing Key Pairs:

name - (Required) The group's name.
path - (Optional, default "/") Path in which to create the group.

EOF
    default     = []
}

variable "groups_policies" {
    description = <<EOF
List of policy Maps where
Map key - "<Group name>.<Policy Name>"
Map Value - A Map of 2 Attributes:
        name: The name of the Role
        arn: ARN of the policy
EOF
    default = []  
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
ssh_key_status - (Optional, default "active") (Optional) The status to assign to the SSH public key.

force_mfa - (Optional, default "yes") Whether to enforce IAM user for MFA
            Only applies when create_force_mfa_policy is true

groups - (Optional) Comma separated value of the IAM groups
EOF
    default = []
} 

variable "users_default_tags" {
    description = "(Optional) A map of tags to assign to all Users."
    type = map
    default = {}
}

variable "mfa_policy_tags" {
    description = "(Optional) A map of tags to assign to all Policies."
    type = map
    default = {}
}

