resource "aws_elastic_beanstalk_application" "tasklist" {
  name = "tasklist"
  description = "tasklist application"
}

resource "aws_elastic_beanstalk_environment" "webapi-dev" {
  name = "webapi-dev"
  application = "${aws_elastic_beanstalk_application.tasklist.name}"
  cname_prefix = "tasklist-webapi-dev"
  description = "env for tasklist webapi dev"
  tier = "WebServer"
  solution_stack_name = "64bit Amazon Linux 2016.03 v2.1.3 running Docker 1.11.1"

  setting {
    namespace = "aws:ec2:vpc"
    name = "VPCId"
    value = "${aws_vpc.main-vpc.id}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name = "Subnets"
    value = "${aws_subnet.public-c.id}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name = "ELBSubnets"
    value = "${aws_subnet.public-c.id}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "true"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name = "MaxSize"
    value = 1
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "EC2KeyName"
    value = "general"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "${aws_iam_instance_profile.webapi-profile.arn}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application"
    name = "Application Healthcheck URL"
    value = "/tasks"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "ServiceRole"
    value = "aws-elasticbeanstalk-service-role"
  }

}
