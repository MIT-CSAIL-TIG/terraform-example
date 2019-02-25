#cloud-config

# root access via pubkey really eases provisioning
disable_root: ${disable_root}

package_update: true
package_upgrade: ${upgrade}
packages: ${packages}

puppet:
  install: true
  conf:
    agent:
      server: "puppet.csail.mit.edu"
      ca_server: "puppet-ca.csail.mit.edu"
      certname: "%i.novalocal"
      pluginsync: true
    ca_cert: |
      -----BEGIN CERTIFICATE-----
      MIICbTCCAdagAwIBAgIJAOIAhQiP/XY8MA0GCSqGSIb3DQEBBQUAMCoxKDAmBgNV
      BAMMH1B1cHBldCBDQTogaGVuc29uLmNzYWlsLm1pdC5lZHUwHhcNMTcwMjI4MjEy
      NDI4WhcNMjcwMjI2MjEyNDI4WjAqMSgwJgYDVQQDDB9QdXBwZXQgQ0E6IGhlbnNv
      bi5jc2FpbC5taXQuZWR1MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCqWQui
      8Vg55H8pGl4gooTYP0oM7OMMvl2O+braIizTa9YtxUM74Z+qJpzbsUaqf53idDmZ
      ga4yWPnfdPqCgMDnMxusBcKi8hMPI/H01XoSR/RaosJTTuaXWcnzI9TRhR1a8yDa
      DGOZHyfMtCYZ0NmKIyy1xk8wVrQWSQQIxTwgawIDAQABo4GaMIGXMAwGA1UdEwQF
      MAMBAf8wDgYDVR0PAQH/BAQDAgEGMDcGCWCGSAGG+EIBDQQqFihQdXBwZXQgUnVi
      eS9PcGVuU1NMIEludGVybmFsIENlcnRpZmljYXRlMB0GA1UdDgQWBBTn8xFVc8RS
      l97+HCokfhBnXZ+JNjAfBgNVHSMEGDAWgBTn8xFVc8RSl97+HCokfhBnXZ+JNjAN
      BgkqhkiG9w0BAQUFAAOBgQB0K/esbnYEZ+hmmrSkGOK5+5Ek9EjeSGg3WX1aON7/
      BKMzVSqv+QL6/hThj/AAdU4PyRLmgwhAvO2BcPfYrBx+00QmAH+tEtj+mnwzkz7d
      o+TTI18Mpw5jJ2T8WCsU9KryATnRybZ3nho5bC7j9cjEU+i0e24kYo62yQadS/YU
      EA==
      -----END CERTIFICATE-----
write_files:
- content: |
    ephemeralnode=${ephmeralnode}
    familyoverride=${familyoverride}
    group=${group}
    cluster=${cluster}
    role=${role}
    owner=${owner}
    autofs=${autofs}
  owner: root:root
  mode: '0644'
  path: /etc/facter/facts.d/csail.txt
${puppet_on_boot_vars}
  owner: root:root
  mode: '0755'
  path: /tmp/puppet_on_boot.vars
${puppet_on_boot}
  owner: root:root
  mode: '0755'
  path: /tmp/puppet_on_boot.sh
${wait_for_puppet}
  owner: root:root
  mode: '0755'
  path: /tmp/wait_for_puppet.sh
${package_mirrors}
runcmd:
  # cc_puppet module too dumb to actually enable puppet so if we do
  # need to install it still won't run
  - [ puppet, agent, --enable ]
  - [ /bin/bash, /tmp/puppet_on_boot.sh ]

power_state:
  mode: reboot
  condition: ${reboot}
