output "assume_role_url" {
  description = "URL to assume the newly created role in AWS."
  value       = "https://signin.aws.amazon.com/switchrole?account=${data.aws_caller_identity.current.account_id}&roleName=${urlencode(aws_iam_role.role.name)}"
}
