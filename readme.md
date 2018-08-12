# Recent Stable Linux Kernel for Debian and Ubuntu

This project contains scripts for building the recent stable Linux kernel from sources from [www.kernel.org/](https://www.kernel.org/).

- [How to configure](#how-to-configure)
- [How to build](#how-to-build)
- [How to setup a builded kernel](#how-to-setup-a-builded-kernel)
- [Troubleshooting](#troubleshooting)
	- [Docker doesn't work after upgrading to a new kernel](#docker-doesnt-work-after-upgrading-to-a-new-kernel)
	- [VirtualBox guest extensions don't work after installing a new kernel](#virtualbox-guest-extensions-dont-work-after-installing-a-new-kernel)
	- [VirtualBox from Ubuntu 16.04 repsitory doesn't work](#virtualbox-from-ubuntu-1604-repsitory-doesnt-work)
- [License](#license)

## How to configure

First of all, it is necessary to prepare the configuration file.

If you don't want manually configure new kernel options, execute: `./configure.sh VERSION olddefconfig`

If you want to manually configure new options, execute: `./configure.sh VERSION oldconfig`

If you want to modify configuration, execute: `./configure.sh VERSION menuconfig`

## How to build

```
./build-kernel.sh VERSION
```

After the build is finished, directory results-VERSION-dtk-TIMESTAMP will contain debian packages
with the new kernel.

## How to setup a builded kernel

```
cd results-VERSION-dtk-TIMESTAMP
sudo dpkg -i *.deb
```

## Troubleshooting

### Docker doesn't work after upgrading to a new kernel

- check the kernel configuration with https://github.com/moby/moby/blob/master/contrib/check-config.sh

- if docker daemon doesn't start with the error

  ```
  level=error msg="[graphdriver] prior storage driver aufs failed: driver not supported"
  ```

  remove folder /var/lib/docker/auf with command: `sudo rm -rf /var/lib/docker/aufs`

### VirtualBox guest extensions don't work after installing a new kernel

E.g.:

```
curl -O https://download.virtualbox.org/virtualbox/5.2.12/VBoxGuestAdditions_5.2.12.iso
sudo mount -o loop ./VBoxGuestAdditions_5.2.12.iso /mnt
sudo apt-get install -y libelf-dev
cd /mnt && sudo ./VBoxLinuxAdditions.run
```

### VirtualBox from Ubuntu 16.04 repsitory doesn't work

It doesn't work because of a [compilation issue with vboxpci](https://www.virtualbox.org/ticket/17683).

Solution: install VirtualBox from the [official website](https://www.virtualbox.org/wiki/Downloads).

## License

MIT
