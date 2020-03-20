variable "mfa_max_age" {
  description = "Max age (in seconds) that an MFA token is valid."
  type        = number
  default     = 14400
}

variable "name_prefix" {
  description = "Optional name_prefix to use for generated resources."
  type        = string
  default     = null
}

variable "permissions" {
  description = "AWS policy to allow after assuming role."
  type        = string
}

variable "role_name" {
  description = "Explicit role name for assuming."
  type        = string
  default     = null
}

variable "tags" {
  description = "AWS tags to apply to resources."
  type        = map(string)
  default     = {}
}

variable "vendor_aws_id" {
  description = "AWS account ID to delegate access to."
  type        = number
}
