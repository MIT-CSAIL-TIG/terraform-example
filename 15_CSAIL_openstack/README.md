What's in the example
=====================

Identical to 10_modular-openstack except using a more specialized
../modules/csail-cloudcfg/ which places VM under CSAIL management.

Also uses a differetn default "image" variable to reference a CSAIL
specific image that has most of the heavy lift done (though a generic
Ubuntu cloud image would work it would take upto 30min to complete
setup)
