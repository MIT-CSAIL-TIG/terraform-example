# this is a module rather than a template so it can have defaults and
# combine multiple templates.

####################################
####      general variables      ###
####################################

# injected pub key for root or just default user
variable "disable_root" {
  type    = "string"
  default = "false"
}

# for (more) clarity in var files ${ssh_keys} should contain the key
# as well as value
#
#variable "ssh_authorized_keys" {
#  default = <<EOF
#ssh_authorized_keys:
#  - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ5qw4kh1DukZPpNpo70WTHY756iNkBXERCydT2+Jaf/ jon@amergin
#EOF
#}
# but default to no keys rather than my keys
variable "ssh_authorized_keys" {
  default = ""
}

# list of packages in string formated yaml list :)
# "[ package1, package2, packageN]"
variable "packages" {
  type    = "string"
  default = "[]"
}

# run upgrade on build?
variable "upgrade" {
  type    = "string"
  default = "true"
}

# Should we reboot on completeion
# to potentially activate kernel updates
variable "reboot" {
  type    = "string"
  default = "True"
}

# catch all extra to dump arbitrary cloudcfg bits
# at the end
variable "extra_config" {
  type    = "string"
  default = ""
}

### assumptions in template we may want to paramereize later:
#   alawys update and upgrade package
#   reboot after first boot incase htese updates catch a new kernel
###

####################################
###  vars for facts.d/csail.txt  ###
###  this is how CSAIL ssytems   ###
###  ask for various managed     ###
###  options                     ###
####################################

# ephemeral node should be "true"
# for VMs (with ephemeral root disks)
variable "ephmeralnode" {
  type    = "string"
  default = "true"
}

# only valid option is "_minimal"
# which will get local (rahter than AFS) homesdirs
variable "familyoverride" {
  type    = "string"
  default = ""
}

# Your email address, mostly for receiving root mail
variable "owner" {
  type    = "string"
  default = ""
}

# wejter to install autofs manafed NFS mount system
variable "autofs" {
  type    = "string"
  default = "false"
}

variable "group" {
  type    = "string"
  default = "none"
}

variable "cluster" {
  type    = "string"
  default = "none"
}

variable "role" {
  type    = "string"
  default = "none"
}

# this controlls if we repoint package mirror at ubuntu.csail or not.
# options are "local" or "remote", if you're running in EC2 use remote

variable "launch_zone" {
  type    = "string"
  default = "local"
}

####################################
###        render cloudcfg       ###
####################################

data "template_file" "cloudcfg" {
  template = "${file("${path.module}/cloudcfg.tpl")}"

  vars {
    # Externally accessable variables:
    disable_root        = "${var.disable_root}"
    ssh_authorized_keys = "${var.ssh_authorized_keys}"
    packages            = "${var.packages}"
    ephmeralnode        = "${var.ephmeralnode}"
    familyoverride      = "${var.familyoverride}"
    group               = "${var.group}"
    cluster             = "${var.cluster}"
    role                = "${var.role}"
    owner               = "${var.owner}"
    autofs              = "${var.autofs}"
    reboot              = "${var.reboot}"
    upgrade             = "${var.upgrade}"
    extra_config        = "${var.extra_config}"

    # load correct package_mirrors if needed
    package_mirrors = "${file("${path.module}/${var.launch_zone}_package_mirrors.frag")}"

    # Note the following are sourced as yaml fragments
    # this helps maintain required indentation
    # for yaml multi line string formatting
    puppet_on_boot_vars = "${file("${path.module}/puppet_on_boot.vars.frag")}"

    puppet_on_boot  = "${file("${path.module}/puppet_on_boot.sh.frag")}"
    wait_for_puppet = "${file("${path.module}/wait_for_puppet.sh.frag")}"
  }
}

####################################
###           outputs            ###
####################################

output "cloudcfg" {
  value = "${data.template_file.cloudcfg.rendered}"
}
