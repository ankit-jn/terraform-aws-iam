locals {
  policy_attachments = flatten([ for group in var.groups: [
        for policy in group.policy_arns: {
          group_name = group.name
          policy_name = policy.name
          policy_arn = policy.arn
        }
      ]])

  group_policies = {
        for attachment in aws_iam_group_policy_attachment.this:
            attachment.group => attachment.policy_arn...
    }

  group_cross_account_policies = {
        for attachment in aws_iam_group_policy_attachment.cross_account:
            attachment.group => attachment.policy_arn
    }
}
