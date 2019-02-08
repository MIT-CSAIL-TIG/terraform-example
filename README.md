Prerequisites
=============

Terraform Installation
----------------------

Download latest [`terraform`](https://www.terraform.io/downloads.html)
binary and install in your PATH

This example was written using v0.11.11

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
