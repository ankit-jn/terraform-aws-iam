#############################################################################################
## Account Password Policy
##
## There is only a single policy allowed per AWS account. 
## An existing policy will be lost when using this resource as an effect of this limitation.
#############################################################################################

resource "aws_iam_account_password_policy" "this" {
  count = var.manage_account_password_policy ? 1 : 0

  allow_users_to_change_password = lookup(var.password_policy, "allow_users_to_change_password", "yes") == "yes"? true : false
  hard_expiry                    = lookup(var.password_policy, "hard_expiry", "no") == "yes"? true : false
  max_password_age               = lookup(var.password_policy, "max_password_age", 0)
  minimum_password_length        = lookup(var.password_policy, "minimum_password_length", 8)
  password_reuse_prevention      = lookup(var.password_policy, "password_reuse_prevention", null)
  require_lowercase_characters   = lookup(var.password_policy, "require_lowercase_characters", "yes") == "yes"? true : false
  require_uppercase_characters   = lookup(var.password_policy, "require_uppercase_characters", "yes") == "yes"? true : false
  require_numbers                = lookup(var.password_policy, "require_numbers", "yes") == "yes"? true : false
  require_symbols                = lookup(var.password_policy, "require_symbols", "yes") == "yes"? true : false
}
