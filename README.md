Prerequisites
=============

Terraform Installation
----------------------

Download latest [`terraform`](https://www.terraform.io/downloads.html)
binary and install in your PATH

This example was written using v0.11.11

For a general introdution to terraform see
https://learn.hashicorp.com/terraform/ these examples are a detailed
examination of a narrow use case.

OpenStack Authentication
------------------------

Most examples assume you have access to an
[OpenStack](https://openstack.org) private cloud.


The terraform OpenStack provider plugin  uses the standard
[`~/.config/openstack/clouds.yaml`](https://docs.openstack.org/python-openstackclient/rocky/configuration/index.html)
file to configure connection and authentication information for your
cloud.

A minimal example of this for (MIT CSAIL)[https://www.csail.mit.edu]
Lab memebrs is:

    clouds:
       default:
           auth:
               auth_url: https://keystone.csail.mit.edu:35358/
               user_domain_name: Default
               project_domain_name: Default
               project_name: <PROJECT_NAME>
               username: <CSAIL EMAIL ADDRESS>
           region_name: CSAIL_Stata
           identity_api_version: 3
           
Other users will need to check with their cloud provider for the
correct values to fill in here.

### A Note On Passwords

Terraform won't work if it has to prompt you for your password which is
unfortunate.  You **cloud** add a "password" key to the "auth:"
section of clouds.yaml above but storing passwords in plain text is a
big security no no.

The other option is to temporarily store it on the environment
variable OS_PASSWORD.  This still isn't great, but it's better.  The
trick here is setting that variable without putting your plain text
password into your shell history (which then gets written to disk).

There are several ways to achieve this but we recommend this bit of
shell copy pasta as most portable:

    #!/bin/sh
    echo "Please enter your OpenStack Password: "
    read -sr OS_PASSWORD_INPUT
    export OS_PASSWORD=$OS_PASSWORD_INPUT
 
This will prompt for your password without echoing and export the
proper variable. It won't validate you actually entered the right
thing until you try an action that needs it unfortunately.

Using The Examples
==================

The `modules` directory contains shared code that is abstracted for
reuse among multiple examples.

Other directories contain the specific toy example infrastructures and
`README` files explaining their construction and usage.  Typically the
can be instantiated on your cloud by checking out this repository on a
system with `terraform` installed the changing directory to the
example and running 

    terraform apply

Generally number prefixes suggest order to follow.

Most examples are based on OpenStack but could be adapted to EC2 based
on the 00_simplest-ec2 example.

Terraform supports many many other "providers" as they are called see
https://www.terraform.io/docs/providers/index.html

For future work I hope to include a Google COmpute Engine example
(GCE) but need ot set up a test account there first...
