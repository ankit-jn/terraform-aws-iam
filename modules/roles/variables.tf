variable "trust_account_ids" {
    description = "Comma separated IDs of the account to be trusted on for the IAM role to assume"
    type = string
}

variable "roles" {
    description = "IAM roles to be provisioned"
    default = []
}

variable "default_tags" {
    description = "(Optional) A map of tags to assign to all roles."
    type = map
    default = {}
}
