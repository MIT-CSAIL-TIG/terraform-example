####################################################################
#
# This actually defines and starts the VM using variable from vars.tf
# you should read (and probably edit) that file first
#
######################################################################

# invoke cloudcfg module
# note "my_cloudcfg" is an arbitrary name
# this allow multiple copies of module with different parameters
# in more complex multi-VM configurations

module "my_cloudcfg" {
  # relative path to moduel directory
  source = "../modules/cloudcfg"

  # public variables we want to override
  # others remain default

  ssh_authorized_keys = "${var.ssh_authorized_keys}"
  packages            = "${var.packages}"

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
