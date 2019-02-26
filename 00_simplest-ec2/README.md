What's in the example
=====================

This provides the simplest useful case of launcing a VM on Amazon EC2
and provisioning using cloud-init / cloud-config.

The Files
=========

before execution all *.tf files are merged. 

vars.tf
-------

vars.tf contains variables the user may want to edit or over
ride.

This can be done either in the vars.tf file, on the command line (
`terraform apply -var "servername=my-test-server"` ) or in a user
created terraform.tfvars file in simple `varible=value` pairs or
environment variables in teh form TF_VAR_varname for example
`TF_VAR_servername=my-test-server` 

see
https://learn.hashicorp.com/terraform/getting-started/variables.html
for more complete assignment syntax.

main.tf
-------

This actually creates the VM using variables in vars.tf

vars.tf **could** be elimintated at the literal values placed directly
in this file

outputs.tf
----------

defines "outputs" wich allows easy access to state, in this case
public IP.

when active `terraform output ip` will return the public address of
the VM, `terraform output` will list all outputs and their values.

outputs are not strictly required but particularly in the case of
dynamic IP addressing they are convenient
