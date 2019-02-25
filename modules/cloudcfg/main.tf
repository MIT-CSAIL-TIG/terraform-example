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

### assumptions in template we may want to paramereize later:
#   alawys update and upgrade package
#   reboot after first boot incase htese updates catch a new kernel
###


####################################
###        render cloudcfg       ###
####################################

data "template_file" "cloudcfg" {
  template = "${file("${path.module}/cloudcfg.tpl")}"

  vars {
    # Externally accessable variables:
    disable_root   = "${var.disable_root}"
    packages       = "${var.packages}"
    reboot         = "${var.reboot}"
    upgrade        = "${var.upgrade}"

  }
}

####################################
###           outputs            ###
####################################

output "cloudcfg" {
  value = "${data.template_file.cloudcfg.rendered}"
}
