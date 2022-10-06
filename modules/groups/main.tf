resource aws_iam_group "this" {
    for_each = { for group in var.groups: group.name => group }

    name = each.key
}

resource aws_iam_group_policy_attachment "group" {
    for_each = {
      for attachment in local.policy_attachments : format("%s.%s", attachment.group_name, attachment.policy_name) => attachment
    }

    group = each.value.group_name
    policy_arn = each.value.policy_arn

    depends_on = [
        aws_iam_group.this
    ]
}