What's in the example
=====================

This extends the previous example by using a module to provide a
templated interface to the cloud-config file, and introduces some new
variable to be used in rendering that template.

The resulting VM has no difference from previous example.

Where's the module
==================

The module is in ../modules/cloudcfg/

The Files
=========

vars.tf
-------

provides new variable to populate cloud-config rather that containing
the cloud config in one massive multi-line string.

main.tf
-------

Includes the new module reference

outputs.tf
----------

unchanged
