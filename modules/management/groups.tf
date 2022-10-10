### Create IAM Groups
resource aws_iam_group "this" {
    for_each = { for group in var.groups: group.name => group }

    name = each.key
    path = each.value.path
}

### Attachment of Policies to the Groups
resource aws_iam_group_policy_attachment "this" {
    for_each = {
      for attachment in local.policy_attachments : format("%s.%s", attachment.group_name, attachment.policy_name) => attachment
    }

    group = each.value.group_name
    policy_arn = each.value.policy_arn

    depends_on = [
        aws_iam_group.this
    ]
}

#### Policy document for assuming Cross Account roles
data aws_iam_policy_document "cross_account" {

    for_each = { for group in var.groups: group.name => group
                            if  length(lookup(group, "assumable_roles", [])) > 0 }

    statement {
        sid = "${each.key}-AllowAssumingRolesCrossAccount"

        actions = ["sts:AssumeRole"]

        effect = "Allow"

        resources = lookup(each.value, "assumable_roles", [])
    }
}

## The policy to allow assuming the Cross Account role
resource aws_iam_policy "assume_role_policy" {
    for_each = { for group in var.groups: group.name => group
                        if  length(lookup(group, "assumable_roles", [])) > 0 }

    name   = "${each.key}-AssumeRole"
    description = "Developer group permissions."
    policy = data.aws_iam_policy_document.cross_account[each.value.name].json
}

resource aws_iam_group_policy_attachment "cross_account" {
    for_each = { for group in var.groups: format("%s.%s", group.name, "AllowAssumingRolesCrossAccount") => group
                            if  length(lookup(group, "assumable_roles", [])) > 0 }

    group = each.value.name
    policy_arn = aws_iam_policy.assume_role_policy[each.value.name].arn

    depends_on = [
        aws_iam_group.this
    ]
}