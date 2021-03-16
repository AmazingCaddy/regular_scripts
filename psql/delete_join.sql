DELETE FROM account_email USING account
WHERE account_email.account_id = account.id
  AND account.tenant_id = 1
