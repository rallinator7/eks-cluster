resource "aws_iam_role" "new_iam_role" {
  name               = var.role.name
  description        = var.role.description
  assume_role_policy = var.role.assume_role_policy
  tags               = var.role.tags
}

resource "aws_iam_role_policy_attachment" "new_iam_role_attachment" {
  role       = aws_iam_role.new_iam_role.name
  policy_arn = aws_iam_policy.new_iam_role_policy.arn
}

resource "aws_iam_policy" "new_iam_role_policy" {
  name        = var.role_policy.name
  description = var.role_policy.description
  policy      = var.role_policy.policy
}