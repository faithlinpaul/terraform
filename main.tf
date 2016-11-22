# Create a VPC to launch our instances into
resource "aws_vpc" "default" {
  cidr_block         = "10.0.1.0/24"
  enable_dns_support = "true"

  tags {
    Name = "MGMT_PUBLIC_TOOLING"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "MGMT_PUBLIC_TOOLING"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "default" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.1.0/26"
  map_public_ip_on_launch = true

  tags {
    Name = "MGMT_PUBLIC_TOOLING"
  }
}

# Our default security group
resource "aws_security_group" "jenkins_master" {
  name        = "MGMT_PUBLIC_TOOLING"
  description = "Used in the terraform"
  vpc_id      = "${aws_vpc.default.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    #cidr_blocks = ["10.0.1.0/26"]  #TOTEST: Allow ssh only from within the Internal VPC jumpbox
  }

  # Jenkins Master hosted port
  ingress {
    from_port   = "${var.jenkinsmaster_port}"
    to_port     = "${var.jenkinsmaster_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    #cidr_blocks = ["10.0.1.0/26"]  #TOTEST: Allow jenkins access only from within the Internal VPC
  }

  # Jenkins Master port to listen for slaves
  ingress {
    from_port = 50000
    to_port   = 50000
    protocol  = "tcp"

    #cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = ["10.0.1.0/26"] #TOTEST: Allow slaves only from within the Internal VPC
  }

  # egress {


  #   from_port   = 0


  #   to_port     = 0


  #   protocol    = "-1"


  #   cidr_blocks = ["0.0.0.0/0"]


  # }

  tags {
    Name = "MGMT_PUBLIC_TOOLING_JENKINS_MASTER"
  }
}

resource "aws_security_group" "jenkins_slave" {
  name        = "MGMT_PUBLIC_TOOLING"
  description = "Used in the terraform"
  vpc_id      = "${aws_vpc.default.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    #cidr_blocks = ["10.0.1.0/26"]  #TOTEST: Allow ssh only from within the Internal VPC jumpbox
  }

  tags {
    Name = "MGMT_PUBLIC_TOOLING_JENKINS_SLAVE"
  }
}

resource "aws_key_pair" "auth" {
  key_name = "${var.key_name}"

  public_key = "${file(var.public_key_path)}"
}

###EC2 Container Registry - Docker Registry
resource "aws_ecr_repository" "jenkins" {
  name = "${var.aws_ecr_repository}"
}
