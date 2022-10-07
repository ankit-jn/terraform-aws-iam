variable "policies" {
    description = "List of Policies to create"
    default = []
} 

variable "default_tags" {
    description = "(Optional) A map of tags to assign to all Policies."
    type = map
    default = {}
}
