####################################################################
#
# This actually defines and starts the VM using variable from vars.tf
# you should read (and probably edit) that file first
#
######################################################################

# with this commented out terraform will use the "default" identity in
# ~/.aws/credentials , this would set it to use an alternate file
# with "terraform" idetity
provider "aws" {
  region = "us-east-2"

  #  shared_credentials_file = "../common/aws_cred.ini"
  #  profile                 = "terraform"
  version = "~> 1.60"
}

resource "aws_instance" "terraform_test" {
  ami           = "${data.aws_ami.ubuntu_bionic.id}"
  instance_type = "${var.instance_type}"
  user_data     = "${var.cloudcfg}"

  tags {
    Name = "${var.servername}"
  }

  security_groups = "${var.security_groups}"
}
