variable "users" {
    description = "List of Users to create"
    type = list
    default = []
} 

variable "tags" {
    description = "(Optional) A map of tags to assign to all users."
    type = map
    default = {}
}

variable "force_mfa_policy_arn" {
    description = "ARN of FOrce MFA policy"
    type        = string
}
