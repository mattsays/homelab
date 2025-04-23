# Additional Notes

1. Update the `wg.conf` file with the correct credentials.

2. Add the following lines to the container configuration:

```
lxc.cgroup.devices.allow: a
lxc.cap.drop:
lxc.cgroup2.devices.allow: c 10:200 rwm
lxc.mount.entry: /dev/net/tun dev/net/tun none bind,create=file
```
