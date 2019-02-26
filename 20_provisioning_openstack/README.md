What's in the example
=====================

This extends the previous example by using "provisioners" to copy a
local file into the new VM and to execute shell comands remotely and
locally.

see https://www.terraform.io/docs/provisioners/index.html

The Files
=========

vars.tf
-------

unchanged

main.tf
-------

Includes the new provisioner stanzas near bottom of file. Also
defaults to **not** rebooting after updates to preven trebootign
during provisioning.

outputs.tf
----------

unchanged
