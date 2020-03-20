data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["true"]
    }

    condition {
      test     = "NumericLessThan"
      variable = "aws:MultiFactorAuthAge"
      values   = [var.mfa_max_age]
    }

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.vendor_aws_id}:root"]
    }
  }
}

resource "aws_iam_policy" "policy" {
  description = "Vendor role policy: ${var.vendor_aws_id}"
  name_prefix = var.name_prefix
  policy      = var.permissions
}

resource "aws_iam_role" "role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  description        = "Vendor role: ${var.vendor_aws_id}"
  name               = can(coalesce(var.role_name)) ? var.role_name : null
  name_prefix        = can(coalesce(var.role_name)) ? null : try(coalesce(var.name_prefix), null)
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "attachment" {
  policy_arn = aws_iam_policy.policy.arn
  role       = aws_iam_role.role.id
}
