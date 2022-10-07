output "organizations_accounts" {
    value = { for account_name, account in aws_organizations_account.this :
                account_name => {
                    id  = account.id
                    arn = account.arn
                }
            }
}