# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}",
  access_key = "*"
  secret_key = "*"
}
# Create a VPC to launch our instances into
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16",
  enable_dns_support = true,
  enable_dns_hostnames = true
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
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
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "default" {
  name = "aws_default"
  description = "Default security group"
  vpc_id      = "${aws_vpc.default.id}"
  # inbound access from anywhere
  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file("~/.ssh/terraform_ssh_key.pub")}"
}

resource "aws_instance" "lb" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
      type = "ssh"
      user = "ubuntu"
      agent = true
      key_file = "${file("~/.ssh/terraform_ssh_key.pub")}"
      timeout = "2m"
    }
  tags {
     Name = "lb1"
     Group = "lbs"
   }

  instance_type = "${var.aws_instance_type}"
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  subnet_id = "${aws_subnet.default.id}"
  provisioner "remote-exec" {

    inline = [
      "sudo apt-get -y update"
    ]
  }
}

resource "aws_instance" "app1" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
      type = "ssh"
      user = "ubuntu"
      agent = true
      key_file = "${file("~/.ssh/terraform_ssh_key.pub")}"
      timeout = "2m"
    }
  tags {
    Name = "app1"
    Group = "apps"
  }
  instance_type = "${var.aws_instance_type}"
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  subnet_id = "${aws_subnet.default.id}"
  provisioner "remote-exec" {

    inline = [
      "sudo apt-get -y update"
    ]
  }
}
resource "aws_instance" "app2" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
      type = "ssh"
      user = "ubuntu"
      agent = true
      key_file = "${file("~/.ssh/terraform_ssh_key.pub")}"
      timeout = "2m"
    }
  tags {
      Name = "app2"
      Group = "apps"
    }
    instance_type = "${var.aws_instance_type}"
    ami = "${lookup(var.aws_amis, var.aws_region)}"
    key_name = "${var.key_name}"
    vpc_security_group_ids = ["${aws_security_group.default.id}"]
    subnet_id = "${aws_subnet.default.id}"
    provisioner "remote-exec" {

      inline = [
        "sudo apt-get -y update"
      ]
    }
}
resource "aws_instance" "app3" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
      type = "ssh"
      user = "ubuntu"
      agent = true
      key_file = "${file("~/.ssh/terraform_ssh_key.pub")}"
      timeout = "2m"
    }
  tags {
      Name = "app3"
      Group = "apps"
    }
    instance_type = "${var.aws_instance_type}"
    ami = "${lookup(var.aws_amis, var.aws_region)}"
    key_name = "${var.key_name}"
    vpc_security_group_ids = ["${aws_security_group.default.id}"]
    subnet_id = "${aws_subnet.default.id}"
    provisioner "remote-exec" {

      inline = [
        "sudo apt-get -y update"
      ]
    }
}

# create db
resource "aws_instance" "db1" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
      type = "ssh"
      user = "ubuntu"
      agent = true
      key_file = "${file("~/.ssh/terraform_ssh_key.pub")}"
      timeout = "2m"
    }
  tags {
    Name = "db1"
    Group = "dbs"
  }
  instance_type = "${var.aws_instance_type}"
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  subnet_id = "${aws_subnet.default.id}"
  provisioner "remote-exec" {

    inline = [
      "sudo apt-get -y update"
    ]
  }
}
