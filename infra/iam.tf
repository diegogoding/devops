data "aws_iam_policy" "eb_cloudwatch" {
  name = "CloudWatchLogsFullAccess"
}


resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = var.eb_role_name
  policy_arn = data.aws_iam_policy.eb_cloudwatch.arn
}
