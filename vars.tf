variable "public_key_path" {
  description = "",
  default = "~/.ssh/terraform_ssh_key.pub"
}

variable "key_name" {
  description = "Desired name of AWS key pair",
  default = "terraform_ssh_key"
}

variable "aws_region" {
  description = "AWS region to launch servers.",
  default     = "us-west-2"
}

variable "aws_instance_type" {
  description = "AWS instance type",
  default = "t2.micro"
}
# Ubuntu Precise 12.04 LTS (x64)
variable "aws_amis" {
  default = {
    eu-west-1 = "ami-b1cf19c6"
    us-east-1 = "ami-de7ab6b6"
    us-west-1 = "ami-3f75767a"
    us-west-2 = "ami-5189a661"
  }
}
