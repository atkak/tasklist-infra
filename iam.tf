resource "aws_iam_role" "webapi-ec2-role" {
  name = "tasklist-webapi-ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "eb-webtier-attach" {
  name = "eb-webtier-attach"
  roles = ["${aws_iam_role.webapi-ec2-role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_policy_attachment" "eb-multicontainer-docker-attach" {
  name = "eb-multicontainer-docker-attach"
  roles = ["${aws_iam_role.webapi-ec2-role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}

resource "aws_iam_policy_attachment" "dynamo-fullaccess-attach" {
  name = "dynamo-fullaccess-attach"
  roles = ["${aws_iam_role.webapi-ec2-role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_instance_profile" "webapi-profile" {
  name = "tasklist-webapi-profile"
  roles = ["${aws_iam_role.webapi-ec2-role.name}"]
}
