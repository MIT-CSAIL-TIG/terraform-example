#cloud-config

# root access via pubkey really eases provisioning
disable_root: ${disable_root}

package_update: true
package_upgrade: ${upgrade}
packages: ${packages}

power_state:
  mode: reboot
  condition: ${reboot}
