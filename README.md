# dev-vm
VM de desenvolvimento do E-vidence

## Instalation

Install:

 * https://www.virtualbox.org/wiki/Downloads
 * https://www.vagrantup.com/downloads.html

then run:

```bash
mkdir e-vidence
cd e-vidence
git clone https://github.com/E-vidence/api.git
git clone https://github.com/E-vidence/etl.git
git clone https://github.com/E-vidence/dev-vm.git
git clone https://github.com/E-vidence/web-cli.git
cd dev-vm
vagrant up
```

> **IMPORTANT:** DO NOT USE `vagrant provision` unless you WANT lose your database data. 

Ajust the `/etc/hosts` file:

```
192.168.100.100 api.e-vidence.local api
192.168.100.100 web.e-vidence.local web
```

> On mac, it's located on `/private/etc/hosts`, on Linux on `/etc/hosts` and on Windows on `c:/Windows/System32/Drivers/etc/hosts`.

## Usage

* [http://api.e-vidence.local](http://api.e-vidence.local)
* [http://web.e-vidence.local](http://web.e-vidence.local)

Tested on Mac OS X and Ubuntu 14.04 LTS.