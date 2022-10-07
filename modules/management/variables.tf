variable "manage_account_password_policy" {
    description = "Flag to decide if manage account Password Policy"
    type        = bool
}

variable "password_policy" {
    description = "Password Policy Management rules"
    type        = map(string)
}

variable "create_force_mfa_policy" {
    description = "ARN of FOrce MFA policy"
    type        = bool
    default     = true
}

variable "groups" {
    description = "List IAM Group to be created along with policies to be assigned"
    default     = []
}

variable "users" {
    description = "List of Users to create"
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

