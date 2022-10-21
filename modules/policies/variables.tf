variable "policies" {
    description = <<EOF
(Optional) List of Map for IAM Policies with the follwoing Key Pairs:

name        : The name of the policy.
              (Required)

policy_file : Policy File name; Policy content to be add to the policy will be read from the
              JSON document `<policy_file>` from the directory "policies" under root directory.
              (Required)

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
