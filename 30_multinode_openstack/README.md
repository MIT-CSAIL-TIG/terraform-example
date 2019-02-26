What's in the example
=====================

This extends the previous example by launching multiple VMs and
copying a different datafile to each.

    terraform apply -var "count=$(( $( ls files/data* | wc -l ) - 1 ))"
    
will launch on VM for each data file in the files subdirectory.

The Files
=========

vars.tf
-------

introduces the "count" variable with no default requiring the user to specify

main.tf
-------

Uses the "count" variable to launch multiple VM and the current index
to append and integer to VM name and for selecting which data file to
copy to each VM.

outputs.tf
----------

since we now have multiple instances slight changes are required to
glob all instaces.
