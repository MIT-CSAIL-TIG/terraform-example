- content: |
    #!/bin/bash
    source /tmp/puppet_on_boot.vars
    
    # this is meant to be remote_exec'ed from terreform
    # to prevent instance from being marked "created"
    # until puppe thaas run.  This is useful for systems
    # that shoudl be created befor eold resource is destroyed to
    # to prevent service gaps (nova-conductor is an example)
    
    until [ -f "$touch_file" ]; do
        sleep $check_seconds
    done
