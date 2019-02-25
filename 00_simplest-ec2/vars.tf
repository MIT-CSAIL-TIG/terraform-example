# see https://www.terraform.io/docs/configuration/variables.html
# for general documentation on variable syntax

############################################################
# Simple varibales to define the VM
# make sure "image" and "flavor" are valid
# on your cloud
############################################################
variable "servername" {
  default = "terraform-test"
}

variable "instance_type" {
  default = "t2.micro"
}

# note this is a list type variable
# also these vary by project so you
# will need to modify this
variable "security_groups" {
  default = ["default", "icmp", "ssh-only"]
}

############################################################
# see https://cloudinit.readthedocs.io/en/latest/ for all the fun you
# can do here in practice this should be modularized and rendered from
# a template (which we will show in a seperate example but for
# simplest case here's a minimal in line example as a simple string
# variable, note "HEREDOC" syntax for multiline string
############################################################

variable "cloudcfg" {
  type = "string"

  default = <<EOF
#cloud-config

# set (possibly multiple) public keys
# note you can but ed25519 type keys here which you can't do directly
# in OpenStack becuase of limitation in python libraries they use
#
# YOU PROBABLY WANT TO CHANGE THESE :)
#
ssh_authorized_keys:
  - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ5qw4kh1DukZPpNpo70WTHY756iNkBXERCydT2+Jaf/ jon@amergin
  - ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAv9BNbG3fZ8MoEPlJfoYooc49DL4QTJ1Wa7O0qPCT60tPs9c4q1CY2PpcPoJk6G14URdfP3gVOGP/basuEFyNv0TI8RSxHE8uIJLdZ8mluxHMVXIvp7w2yMk8NqY2HsyrXx7HCDkpwMzxtBbkq/rsP3vlHvSur448SdYYRB1AFXKiDxt9kYrOnnL9Han1qkB3EHq8+CsXG5zshvfzliqRUonzybdLIy0SG9+1dXpLjKkp6lw9MxcTTQrCOIRyPPMIP+nYxpekWiPfWd8I1Ablynu5WoTevb9dFyP3pwkAykl9FEdyZT9GbYUfmfCSgbiY+PYnMEsnX2mPLTqDwNFKsw== jon@kvas


# root access via pubkey really eases provisioning
# so you can access as "ubuntu" or "root"
disable_root: false

# refresh package databas eand run upgrades
package_update: true
package_upgrade: true

# install a few extras
packages: [ "mosh", "emacs-nox" ]

# if set to true reboot after updates
# to potentially pick up kenel updates
power_state:
  mode: reboot
  condition: true
EOF
}
