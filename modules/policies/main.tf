locals {
  policy_contents = { for policy in var.policies : 
                            policy.name => merge(policy, { "policyjson" : data.template_file.policy_template[policy.name].rendered })}
}

data template_file "policy_template" {
    for_each = { for policy in var.policies: policy.name => policy } 
  
    template = file("${path.root}/policies/${each.key}.json")
}

## The IAM Policies to be created
resource aws_iam_policy "this" {
    for_each = local.policy_contents

    name = each.key
    description = lookup(each.value, "description", each.key)
    path = lookup(each.value, "path", "/")

    policy = each.value.policyjson

    tags = merge(var.default_tags, lookup(each.value, "tags", {}))
}
