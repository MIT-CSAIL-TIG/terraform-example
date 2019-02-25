Overview
========

this directory is to contain reusable shared modules referenced by the
exmaple directories.

cloudcfg
--------

cloudcfg module does some basic system setup using cloudinit tools at
VM boot.

It very simply renders a template based on variables provided through
the module to set:

* administrative ssh keys
* packages to install
* toggle package upgrade on build
* toggle reboot after update
* toggle enable/disable root

csail-cloudcfg
--------------

this is an extended version of the basic cloudfg which also setup
CSAIL puppet management.

**CAUTION** If you are not running on systems hosted and managed by MIT CSAIL you
do not want to touch this, it might hurt you.  If it works at all it
will at least give us root access to your servers...

