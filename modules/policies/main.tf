data template_file "policy_template" {
  for_each = { for policy in var.policies: policy.name => policy } 
  
  template = file("${path.root}/policies/${each.key}.json")
}


resource aws_iam_policy "this" {
  for_each = local.policy_contents

  name = each.key
  path = lookup(each.value, "path", "/")
  description = lookup(each.value, "description", each.key)

  policy = each.value.policyjson

  tags = merge(var.default_tags, lookup(each.value, "tags", {}))
}
