locals {
  policy_contents = { for policy in var.policies : 
                            policy.name => merge(policy, { "policyjson" : data.template_file.policy_template[policy.name].rendered })}
}