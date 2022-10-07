locals {

    policy_attachments = flatten([ for role in var.roles: [
        for policy in role.policy_arns: {
          role_name = role.name
          policy_name = policy.name
          policy_arn = policy.arn
        }
      ]])

    role_policies = {
        for attachment in aws_iam_role_policy_attachment.this:
            attachment.role => attachment.policy_arn...
        }

}

data aws_iam_policy_document "trust_policy" {

    for_each = { for role in var.roles : role.name => role }

    statement {
        principals {
        identifiers = split(",", each.value.trust_account_ids)
        type = "AWS"
        }

        actions = [
        "sts:AssumeRole"
        ]

        effect = "Allow"
    }
}

resource aws_iam_role "this" {
    for_each = { for role in var.roles : role.name => role }
 
    name                    = each.key
    description             = each.value.description
    max_session_duration    = each.value.max_session_duration
    path                    = each.value.path
    assume_role_policy      = data.aws_iam_policy_document.trust_policy[each.key].json

    tags = merge(var.default_tags, each.value.tags)
}

resource aws_iam_role_policy_attachment "this" {
    for_each = {
      for attachment in local.policy_attachments : format("%s.%s", attachment.role_name, attachment.policy_name) => attachment
    }

    role = each.value.role_name
    policy_arn = each.value.policy_arn

    depends_on = [
        aws_iam_role.this
    ]
}