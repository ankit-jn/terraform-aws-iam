variable "account_alias" {
    description = "(Required) The account alias"
    type        = string
    default     = ""
}

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

name - (Required) The friendly name to assign to the policy.
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

variable "organization_default_tags" {
    description = "(Optional) A map of tags to assign to all Organizational Resources."
    type = map
    default = {}
}