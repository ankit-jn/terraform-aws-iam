data template_file "policy_template" {
    for_each = { for policy in var.policies: policy.name => policy if try(policy.policy_file, "") != "" } 
  
    template = file("${path.root}/${each.value.policy_file}")
}

## The IAM Policies to be created
resource aws_iam_policy "this" {
    for_each = { for policy in var.policies: policy.name => policy }

    name = each.key
    description = lookup(each.value, "description", each.key)
    path = lookup(each.value, "path", "/")

    policy = (try(each.value.policy_content, "") != "") ? each.value.policy_content : data.template_file.policy_template[each.key].rendered

    tags = merge(var.default_tags, lookup(each.value, "tags", {}))
}
