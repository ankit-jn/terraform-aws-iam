## Assume Role Policy Document
data aws_iam_policy_document "trusted_account_role_policy" {

    for_each = { for role in var.trusted_account_roles : role.name => role }

    statement {
        principals {
            identifiers = each.value.account_ids
            type = "AWS"
        }

        actions = [
            "sts:AssumeRole"
        ]

        effect = "Allow"
    }
}

## Assumable IAM Role
resource aws_iam_role "trusted_account_roles" {
    for_each = { for role in var.trusted_account_roles : role.name => role }
 
    name                    = each.key
    description             = each.value.description
    max_session_duration    = each.value.max_session_duration
    path                    = each.value.path
    force_detach_policies   = each.value.force_detach_policies
    assume_role_policy      = data.aws_iam_policy_document.trusted_account_role_policy[each.key].json

    tags = merge(var.default_tags, each.value.tags)
}

## Attachment of IAM role with the Policy
resource aws_iam_role_policy_attachment "trusted_account_role_policy_attachment" {
    for_each = {
      for attachment in local.trusted_account_roles_policies : format("%s.%s", attachment.role_name, attachment.policy_name) => attachment
    }

    role = each.value.role_name
    policy_arn = each.value.policy_arn

    depends_on = [
        aws_iam_role.trusted_account_roles
    ]
}