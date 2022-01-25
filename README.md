# pythontools steps
1. determine target container id
1. determine which node the pod is running on
1. deploy config.gatekeeper.yml
1. uncomment spec.nodeName and set appropriately in dntracer.pod.yaml if using a multinode cluster.
1. deploy pythontools.pod.yaml
1. perform rest of steps inside java-tools pod via kubectl exec `kubectl exec -it python-tools -- /bin/bash`
1. determine the PID of the target process
```
# This can be somewhat tricky, ps and grep are probably the easiest way to determine the real PID.
chroot /host
ps aux | grep python
exit
```

The only tool installed currently is pyspy, but other tools can be install via pip3 live on the image.

Unfortunately, base images (centos8 and rhel/ubi8) don't seem to ship python-debuginfo packages to
allow live debugging via gdb extensions.  The standard python debugger pdb does not support attaching
to live processes.

Other tools available via pip may prove useful.

## pyspy example

This will create a flamegraph of your python process

1. execute `py-spy record --output /tmp/pytrace.svg --pid $PID`
1. run from your workstation `kubectl cp python-tools:/tmp/pytrace.svg pytrace.svg` to copy the locally.


# With kubectl-flame (not tested)

Most likely this will not work out of the box due to containderd.