class apache::install {
    package { 'apache2':
        ensure => installed,
    }
    package { 'apache2-mpm-prefork':
        ensure => installed,
    }
    package { 'apache2-mpm-worker':
        ensure => installed,
    }
    /*
    package { 'libapache2-mod-fcgid':
        ensure => installed,
        require => Class['php-fpm']
    }
    */
    package { 'libapache2-mod-php5':
        ensure => installed
    }
}

class apache::configure {
    
}

define apache::vhost (
    $server_name,
    $docroot,
    $site,
    $ip = "*",
    $port = "80",
    $template = 'apache/virtualhost.erb',
    $server_alias = ""
) {

    $sitesavailable = '/etc/apache2/sites-available'
    $sitesenabled = '/etc/apache2/sites-enabled'

    exec { "site_check_presence_site" :
       path => '/usr/bin',
       command => "test -e $docroot || echo $docroot | grep -q '%'"
    }
   
    file {"$sitesavailable/$site.conf":
        content => template($template),
        owner   => 'root',
        group   => 'root',
        mode    => '655',
        require => Package['apache2'],
        notify  => Service['apache2']
    }
    
    file { "$sitesenabled/$site.conf":
        ensure => 'link',
        target => "$sitesavailable/$site",
        require => Package['apache2'],
        notify  => Service['apache2']
    }
}


class apache::run {
    service { apache2:
        enable => true,
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        require => Class['apache::install', 'apache::configure'],
    }
}

class apache {
    include apache::install
    include apache::configure
    include apache::run
}
