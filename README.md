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
cat .puppet/Vagrantfile |
    sed -e 's/manifests_path = "manifests"/manifests_path = ".puppet\/manifests"/g' |
    sed -e 's/module_path = "modules"/module_path = ".puppet\/modules"/g' > Vagrantfile
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

Create a new Symfony project:

```bash
curl -s http://getcomposer.org/installer | php
php composer.phar create-project symfony/framework-standard-edition vagrant.dev
cd vagrant.dev
```

Fix permissions for app/cache and app/logs:

```bash
setfacl -R -m u:www-data:rwx app/cache app/logs
setfacl -R -d -m u:www-data:rwx app/cache app/logs

setfacl -R -m u:vagrant:rwx app/cache app/logs
setfacl -R -d -m u:vagrant:rwx app/cache app/logs

setfacl -R -m mask:rwx app/cache app/logs
setfacl -R -d -m mask:rwx app/cache app/logs
```

Allow access to web/app_dev.php and web/config.php from your host:

```bash
sed -i 's/\(::1\)/33.33.33.1/' web/app_dev.php
sed -i 's/\(::1\)/33.33.33.1/' web/config.php
```
