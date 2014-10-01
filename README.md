Puppet modules for Symfony development with Vagrant
===================================================

**Note**: I pretty much abandoned this configuration in favour of another one based on chef: https://github.com/jakzal/vagrant-symfony

Quick start
-----------

Clone the puppet modules and manifests into your project:

```bash
cd your-project
git clone git://github.com/jakzal/puppet-symfony.git .puppet
```

Create a Vagrantfile and configure manifests and module paths. You can use
provided example:

```bash
cp .puppet/Vagrantfile Vagrantfile
```

Boot your virtual machine:

```bash
vagrant up
```

ssh into it once it boots:

```bash
vagrant ssh
```

Symfony Standard Edition
------------------------

Use symfony-standard-dev.pp manifest instead of symfony-dev.pp and run your vagrant box:

```bash
vagrant up
```

First time it'll take some time as apt repository needs to be updated and
all the missing packages need to be installed.

Add your domain to /etc/hosts and point it to your VM (i.e. 33.33.33.10 vagrant.dev).

Log into your vagrant box:

```bash
vagrant ssh
```
