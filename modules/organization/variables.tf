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

name    : The name for the organizational unit
          (Required)
parent  : The name the parent organizational unit; If not given; Root will be the parent
          (Optional)
tags    : A map of tags to assign to the OU resource.
          (Optional)

Note: OU hierarchy upto Level 5 is supported in this codebase
EOF
    default     = []
}

variable "organizations_policies" {
    description = <<EOF
(Optional) List of Map for organizations Policies with the follwoing Key Pairs:

name        : The friendly name to assign to the policy.
              (Required)
policy_file : Policy File name; Policy content to be add to the policy will be read from the
              JSON document `<policy_file>` from the directory "org_policies" under root directory.
              (Required)
description : A description to assign to the policy.
              (Optional)
type        : The type of policy to create. Valid values are AISERVICES_OPT_OUT_POLICY, 
              BACKUP_POLICY, SERVICE_CONTROL_POLICY (SCP), and TAG_POLICY.
              (Optional, default `SERVICE_CONTROL_POLICY`)
tags        : (Optional) A map of tags to assign to the policy.

EOF
    default = []
} 

variable "organizations_accounts" {
    description = <<EOF
(Optional) List of Map for member accounts to be created in the current organization with the following Key pais:

name            : Friendly name for the member account.
                  (Required)
email           : Email address of the owner to assign to the new member account.
                  (Required)
role_name       : The name of an IAM role that Organizations automatically preconfigures
                  in the new member account. 
                  (Optional)
access_to_billing: If set to ALLOW, the new account enables IAM users and roles to access 
                   account billing information if they have the required permissions.
                   (Optional, default `ALLOW`)
tags            : A map of tags to assign to the memeber Account resource.
                  (Optional)
EOF
    default = []
} 

variable "organization_default_tags" {
    description = "(Optional) A map of tags to assign to all Organizational Resources."
    type = map
    default = {}
}