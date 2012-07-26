class nginx::install {
    package { 'nginx':
        ensure => installed,
        require => Class['php-fpm']
    }
}

class nginx::configure {
}

class nginx::run {
    service { nginx:
        enable => true,
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        require => Class['nginx::install', 'nginx::configure'],
    }
}

class nginx {
    include nginx::install
    include nginx::configure
    include nginx::run
}
