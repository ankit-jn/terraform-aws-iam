## Assume Role Policy Document
data aws_iam_policy_document "service_linked_role_policy" {

    for_each = { for role in var.service_linked_roles : role.name => role }

    statement {
        principals {
            identifiers = each.value.service_names
            type = "Service"
        }

        actions = [
            "sts:AssumeRole"
        ]

        effect = "Allow"
    }
}

## Assumable IAM Role
resource aws_iam_role "service_linked_roles" {
    for_each = { for role in var.service_linked_roles : role.name => role }
 
    name                    = each.key
    description             = each.value.description
    max_session_duration    = each.value.max_session_duration
    path                    = each.value.path
    force_detach_policies   = each.value.force_detach_policies
    assume_role_policy      = data.aws_iam_policy_document.service_linked_role_policy[each.key].json

    tags = merge(var.default_tags, each.value.tags)
}

# ## Attachment of IAM role with the Policy
resource aws_iam_role_policy_attachment "service_linked_role_policy_attachment" {
    for_each = {
      for k, v in merge(var.service_linked_roles_policies...) : k => v
    }

    role = each.value.role_name
    policy_arn = each.value.policy_arn

    depends_on = [
        aws_iam_role.service_linked_roles
    ]
}