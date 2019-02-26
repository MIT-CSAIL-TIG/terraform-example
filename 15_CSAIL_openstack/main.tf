####################################################################
#
# This actually defines and starts the VM using variable from vars.tf
# you should read (and probably edit) that file first
#
# This is CSAIL Lab Specific and will give our support team
# full control of VMs lauched,
#
# If you aren't a CSAIL Lab member you don not want to do this!
#
######################################################################

# invoke cloudcfg module
# note "my_cloudcfg" is an arbitrary name
# this allow multiple copies of module with different parameters
# in more complex multi-VM configurations

module "my_cloudcfg" {
  # relative path to moduel directory
  source = "../modules/csail-cloudcfg"

  # public variables we want to override
  # others remain default

  ssh_authorized_keys = "${var.ssh_authorized_keys}"
  packages            = "${var.packages}"
  # CSAIL Specific flags
  role   = "${var.role}"
  autofs = "${var.autofs}"
  owner  = "${var.owner}"

  ## this is mostly voodoo leave it :)
  #ephmeralnode = "true"

  ## set to "_minimal" to have local home directories rather than AFS
  ## values other than "" and "_minimal" will break your system
  #familyoverride = "${var.familyoverride}"

  ## set to your group name if TIG manages special configs (like sudoers
  ## or package sets) for your group
  ##
  ## invalid strings here are safely ignored
  #group = "${var.group}"

  ## if you don't knwo you don't need it
  ## invalid strings here are safely ignored
  #cluster = "${var.cluster}"

  ##### back to generic values same as pervious example #####

  # values could be defined directly here rather than indirectly
  # in vars.tf as we're doing here if you prefer
  # these are commented out default values for reference

  # disable_root        = "false"

  # # run upgrade on build?
  # upgrade             = "true"

  # # Should we reboot after pkg upgrade
  # reboot              = "true"

  # # a stub where we can dump arbitrary config at end of tempate
  # extra_config        = "" 
}

resource "openstack_compute_instance_v2" "terraform_test" {
  name        = "${var.servername}"
  image_name  = "${var.image}"
  flavor_name = "${var.flavor}"

  # note reference to "my_cloudcfg" module invocation
  user_data = "${module.my_cloudcfg.cloudcfg}"

  network {
    name = "${var.network}"
  }

  security_groups = "${var.security_groups}"
}
