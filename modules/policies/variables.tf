variable "policies" {
    description = <<EOF
(Optional) List of Map for IAM Policies with the follwoing Key Pairs:

name - (Required) The name of the policy. 
description - (Optional) Description of the IAM policy. Default: Policy Name
path - (Optional, default "/") Path in which to create the policy.
tags - (Optional) A map of tags to assign to the policy.

Note: Policy content to be add to the new policy will be read from the JSON document 
      JSON document must be placed in the directory "policies" under root directory. 
      The naming format of the file: <Value set in name property>.json
EOF
    default = []
} 

variable "default_tags" {
    description = "(Optional) A map of tags to assign to all Policies."
    type = map
    default = {}
}
