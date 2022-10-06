locals {
  policy_attachments = flatten([ for group in var.groups: [
        for policy in group.policy_arns: {
          group_name = group.name
          policy_name = policy.name
          policy_arn = policy.arn
        }
      ]])

  group_policies = {
        for attachment in aws_iam_group_policy_attachment.group:
            attachment.group => attachment.policy_arn...
    }
}
