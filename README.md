# Vendor Access

This module creates an AWS roles for a different account's users to assume. Users
that assume the role require an MFA token to be present that is not older than
`14400` seconds. You can change the expiration time with the `mfa_max_age`
configuration.

This does not use an [External ID][external_id] so users who assume the role
can get web access to AWS easily.

Module configuration also allows overriding optional `name_prefix`, `role_name`,
and `tags`. You cannot use both `name_prefix` and `role_name` at the same time
and precedence will be given to `role_name`.

## Usage

The following example provides an example of how this module can be used. You
provide it with a IAM policy string, desired role name, and the AWS account ID.

```hcl
data "aws_iam_policy_document" "permissions" {
  statement {
    actions   = ["*"]
    resources = ["*"]
  }
}

module "vendor_access" {
  source = "./modules/vendor_access"

  permissions   = data.aws_iam_policy_document.permissions.json
  vendor_aws_id = 123456123456

  # optional configuration
  mfa_max_age   = 200
  name_prefix   = "coffee-"
  role_name     = "DesiredRoleName"
}
```

[external_id]: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-user_externalid.html
