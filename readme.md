# Recent Stable Kernel

This project contains scripts for building a stable vanilla kernel for Debian.

# Rebuild of Linux Kernel for Debian

## How to build a kernel

See https://kernel-handbook.alioth.debian.org/ch-common-tasks.html#s-kernel-org-package

Build script:

```
sudo apt-get update
sudo apt-get build-dep linux -y
sudo apt-get install -y build-essential fakeroot

wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.15.2.tar.xz
tar -xaf linux-4.15.2.tar.xz
cd linux-4.15.2
cp ../.config .

time make -j4 deb-pkg
```

Setup the new kernel:

```
sudo dpkg -i linux-headers-4.15.2_4.15.2-1_amd64.deb
sudo dpkg -i linux-image-4.15.2_4.15.2-1_amd64.deb
```

## Troubleshooting

### Docker doesn't work after upgrading to new kernel

- check the kernel configuration with https://github.com/moby/moby/blob/master/contrib/check-config.sh

- if docker daemon doesn't start with the error

  ```
  level=error msg="[graphdriver] prior storage driver aufs failed: driver not supported"
  ```

  remove folder /var/lib/docker/auf with command: `sudo rm -rf /var/lib/docker/aufs`

### When installing a new kernel into VirtualBox guest machine

After installing a new kernel perform:

```
sudo apt install -y libelf-dev
sudo apt install -y virtualbox-guest-dkms
```

## License

MIT
