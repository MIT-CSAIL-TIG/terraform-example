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

  ### NEW note we don't reboot automatically so we don't cut off our
  ### provisioning scripts
  reboot              = "false"

  ssh_authorized_keys = "${var.ssh_authorized_keys}"
  packages            = "${var.packages}"

  # values could be defined directly here rather than indirectly
  # in vars.tf as we're doing here if you prefer
  # these are commented out default values for reference

  # disable_root        = "false"

  # # run upgrade on build?
  # upgrade             = "true"

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

  ############################################################
  #
  # NEW STUFF
  # https://www.terraform.io/docs/provisioners/index.html
  #
  ############################################################

  # we can also copy arbitrary files in place (uses scp)
  provisioner "file" {
    source      = "files/hello-world.sh"
    destination = "/tmp/hello-world.sh"
  }
 # and run arbitrary remote commands
 provisioner "remote-exec" {
    inline = [
      "chmod 0755 /tmp/hello-world.sh",
      "/tmp/hello-world.sh /root/hello.out",
    ]
  }
 # local commands are also possible
 # this appends the dynamic IP of this host to a file 
 provisioner "local-exec" {
   command = "echo ${openstack_compute_instance_v2.terraform_test.network.0.fixed_ip_v4} >> ips.txt"
 }
}
