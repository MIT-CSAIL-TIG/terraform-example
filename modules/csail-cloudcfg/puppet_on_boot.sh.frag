- content: |
    #!/bin/bash
    source /tmp/puppet_on_boot.vars
    
    # so many things want to lock dpkg at boot up
    # unattended_upgrade, previous puppet install, etc...
    #
    # Note this check may spin forever if something bad
    # happened in previous dpkg attempt
    # see /var/log/cloud-init-output.log to see what's going on
    wait_dpkg_lock () {
        echo  waiting for dpkg to clear.
        until dpkg --force-confold --configure -a; do
            sleep 10
        done
    }
    
    # avoid conflicting runs
    service puppet stop
    # and dpkg runs
    wait_dpkg_lock
    puppet agent -t
    # seriously we suck at dependency ordering...
    # and sometimes so does dpkg
    wait_dpkg_lock
    puppet agent -t
    
    # make wait_for_puppet.sh work
    touch $touch_file
    # let it notice before we exit and cloudint (probably) reboots
    sleep $(( $check_seconds * 3 ))
