provider "aws" {
  region = "us-east-1" # Change to your desired region
}

resource "aws_iam_role" "example_role" {
  name               = var.iam_role_name
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_group_membership" "example_group_membership" {
  name = var.iam_group_name

  users = [aws_iam_role.example_role.name]
}

output "access_key" {
  value = aws_iam_access_key.example_access_key.id
}

output "secret_key" {
  value = aws_iam_access_key.example_access_key.secret
}
