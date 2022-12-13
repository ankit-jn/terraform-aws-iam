variable "policies" {
    description = <<EOF
(Optional) List of Map for IAM Policies with the follwoing Key Pairs:
One of the variable is required: `policy_file` or `policy_content`

name        : The name of the policy.
              (Required)

policy_file : Policy File name with path relative to root directory.
              (Optional)

policy_content : Policy Content (JSON).
              (Optional)

description : Description of the IAM policy. Default: Policy Name
              (Optional) 

path        : Path in which to create the policy.
              (Optional, default "/")

tags        : A map of tags to assign to the policy.
              (Optional)

EOF
    default = []
} 

variable "default_tags" {
    description = "(Optional) A map of tags to assign to all Policies."
    type = map
    default = {}
}
