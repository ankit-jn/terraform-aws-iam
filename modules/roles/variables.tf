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

policies - The Map of 2 different type of Policies where 
Map key - Policy Type [There could be 2 different values : `policy_names`, `policy_names`]<br>
Map Value - A List of Policies as stated below
            policy_names: List of Policy which will be provisioned as part of IAC 
            policy_arns: List of ARN of the policies which are provisioned out of this IAC
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

policies - The Map of 2 different type of Policies where 
Map key - Policy Type [There could be 2 different values : `policy_names`, `policy_names`]<br>
Map Value - A List of Policies as stated below
            policy_names: List of Policy which will be provisioned as part of IAC 
            policy_arns: List of ARN of the policies which are provisioned out of this IAC
EOF
    default = []
}

variable "default_tags" {
    description = "(Optional) A map of tags to assign to all roles."
    type = map
    default = {}
}
