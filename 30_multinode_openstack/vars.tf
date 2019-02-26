# see https://www.terraform.io/docs/configuration/variables.html
# for general documentation on variable syntax

############################################################
#
# NEW if a variable is defined but not given a default
# it must be specified at run time.
#
# for this exaple we want one server for each data file in the
# files directory so this command will specify correct "count"
# value:
#
# terraform apply -var "count=$(( $( ls files/data* | wc -l ) - 1 ))"
#
# it's bit clunky due to terraform usign zero base index hence
# the need to subtract one from what wc gives us...but it works
#
variable "count" {}

############################################################
# Simple varibales to define the VM
# make sure "image" and "flavor" are valid
# on your cloud
############################################################
variable "servername" {
  default = "terraform-test"
}

variable "image" {
  default = "Ubuntu-18.04LTS-amd64"
}

variable "flavor" {
  default = "s1.2core"
}

variable "network" {
  default = "inet"
}

# note this is a list type variable
# also these vary by project so you
# will need to modify this
variable "security_groups" {
  default = ["default", "icmp", "ssh-only"]
}

############################################################
#
# Rather than repeating cloudcfg in its entirety as we did
# in the pervious "simplest" case we cna no only specify
# template variable we want to change from defaults
#
# calling the module and using thes vars is in main.tf 
#
############################################################

# for (more) clarity in var files ${ssh_keys} should contain the key
# as well as value
#
# AGAIN CHANGE KEYS
#
variable "ssh_authorized_keys" {
  default = <<EOF
ssh_authorized_keys:
  - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ5qw4kh1DukZPpNpo70WTHY756iNkBXERCydT2+Jaf/ jon@amergin
  - ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAv9BNbG3fZ8MoEPlJfoYooc49DL4QTJ1Wa7O0qPCT60tPs9c4q1CY2PpcPoJk6G14URdfP3gVOGP/basuEFyNv0TI8RSxHE8uIJLdZ8mluxHMVXIvp7w2yMk8NqY2HsyrXx7HCDkpwMzxtBbkq/rsP3vlHvSur448SdYYRB1AFXKiDxt9kYrOnnL9Han1qkB3EHq8+CsXG5zshvfzliqRUonzybdLIy0SG9+1dXpLjKkp6lw9MxcTTQrCOIRyPPMIP+nYxpekWiPfWd8I1Ablynu5WoTevb9dFyP3pwkAykl9FEdyZT9GbYUfmfCSgbiY+PYnMEsnX2mPLTqDwNFKsw== jon@kvas
EOF
}

# list of packages in string formated yaml list :)
# "[ package1, package2, packageN]"
variable "packages" {
  type    = "string"
  default = "['mosh','emacs-nox']"
}

############################################################
#
# these are other variables that could be over ridden are
# listed in main.tf with default values
#
############################################################

