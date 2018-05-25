# Example of building linux kernel from sources

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
