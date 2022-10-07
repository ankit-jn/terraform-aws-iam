variable "account_alias" {
    description = "(Required) The account alias"
    type        = string
    default     = ""
}

variable aws_service_access_principals {
  default     = []
  description = "description"
}

variable enabled_policy_types {
  default     = []
  description = "List of Organizations Policy Types to enable in the Organization Root"
}

variable feature_set {
  type        = string
  default     = "ALL"
  description = ""
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
    default = []
} 

variable "organization_default_tags" {
    description = "(Optional) A map of tags to assign to all Organizational Resources."
    type = map
    default = {}
}