Puppet modules for PHP development with Vagrant
===============================================

Quick start
-----------

Clone the puppet modules and manifests into your project:

```bash
cd your-project
git clone git://github.com/jakzal/puppet-symfony.git .puppet
cp .puppet/Vagrantfile Vagrantfile
```

Now you can "personalize" your `Vagrantfile`, and finnaly boot your virtual machine:

```bash
vagrant up
```

ssh into it once it boots:

```bash
vagrant ssh
```

Add your domain to /etc/hosts and point it to your VM (i.e. 192.168.10.10 vagrant.dev).
