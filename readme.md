# Recent Stable Linux Kernel for Debian and Ubuntu

This project contains scripts for building the recent stable Linux kernel from sources from [www.kernel.org/](https://www.kernel.org/).

## How to build

```
./configure.sh VERSION oldconfig

# if you want to tweak config options
./configure.sh VERSION menuconfig

./build-kernel.sh VERSION
```

## How to setup builded kernel on Debian and Ubuntu

```
sudo dpkg -i linux-headers-*_amd64.deb
sudo dpkg -i linux-image-*_amd64.deb
sudo dpkg -i linux-libc-dev_*.deb
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
