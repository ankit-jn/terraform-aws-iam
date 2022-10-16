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
EOF
    default = []
}

variable "trusted_account_roles_policies" {
    description = <<EOF
List of policy Maps where
Map key - "<Role name>.<Policy Name>"
Map Value - A Map of 2 Attributes:
        ame: The name of the Role
        arn: ARN of the policy
EOF
    default = []
}

variable "service_linked_roles_policies" {
    description = <<EOF
List of policy Maps where
Map key - "<Role name>.<Policy Name>"
Map Value - A Map of 2 Attributes:
        name: The name of the Role
        arn: ARN of the policy
EOF
    default = []  
}

variable "default_tags" {
    description = "(Optional) A map of tags to assign to all roles."
    type = map
    default = {}
}
