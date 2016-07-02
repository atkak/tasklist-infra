resource "aws_vpc" "main-vpc" {
  cidr_block = "10.1.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags {
    Name = "tasklist"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main-vpc.id}"
  tags {
    Name = "tasklist"
  }
}

resource "aws_subnet" "public-c" {
  vpc_id = "${aws_vpc.main-vpc.id}"
  cidr_block = "10.1.0.0/24"
  availability_zone = "ap-northeast-1c"
  tags {
    Name = "tasklist-public-c"
  }
}

resource "aws_route_table" "public-route" {
  vpc_id = "${aws_vpc.main-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags {
    Name = "tasklist-public"
  }
}

resource "aws_route_table_association" "public-c" {
  subnet_id = "${aws_subnet.public-c.id}"
  route_table_id = "${aws_route_table.public-route.id}"
}
