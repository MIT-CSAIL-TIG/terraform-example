####################################################################
#
# This actually defines and starts the VM using variable from vars.tf
# you should read (and probably edit) that file first
#
######################################################################

resource "openstack_compute_instance_v2" "terraform_test" {
  name        = "${var.servername}"
  image_name  = "${var.image}"
  flavor_name = "${var.flavor}"
  user_data   = "${var.cloudcfg}"

  network {
    name = "${var.network}"
  }

  security_groups = "${var.security_groups}"
}
