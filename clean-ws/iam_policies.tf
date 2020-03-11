# IAM policies needed by the CPI
# The expected policies are defined here: https://github.com/kubernetes/cloud-provider-aws#readme

locals {
  aws_iam_policy_admin_terraform = "${var.stack_name}_cpi_admin_policy"
}




resource "aws_iam_policy" "admin" {
  name        = local.aws_iam_policy_admin_terraform
  path        = "/"
  description = "IAM policy needed by CPI on admin nodes"
  count       = length(var.iam_profile_admin) == 0 ? 1 : 0

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeRegions",
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:BatchGetImage"
      ],
      "Resource": "*"
    }
  ]
}
EOF

}
