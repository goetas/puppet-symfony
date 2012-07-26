class php-fpm::install {
    package { 'php5-fpm':
        ensure => installed,
        require => Class['php-cli']
    }
}

class php-fpm::configure {
    exec { 'php-fpm-set-timezone':
        path => '/usr/bin:/usr/sbin:/bin',
        command => 'sed -i \'s/^[; ]*date.timezone =.*/date.timezone = Europe\/London/g\' /etc/php5/fpm/php.ini',
        onlyif => 'test "`php -r \"echo ini_get(\'date.timezone\');\"`" = ""',
        require => Class['php-fpm::install']
    }
    exec { 'php-fpm-disable-short-open-tag':
        path => '/usr/bin:/usr/sbin:/bin',
        command => 'sed -i \'s/^[; ]*short_open_tag =.*/short_open_tag = Off/g\' /etc/php5/fpm/php.ini',
        onlyif => 'test "`php -r \"echo ini_get(\'short_open_tag\');\"`" = "1"',
        require => Class['php-fpm::install']
    }
}

class php-fpm::run {
    service { php5-fpm:
        enable => true,
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        require => Class['php-fpm::install', 'php-fpm::configure'],
    }
}

class php-fpm {
    include php-fpm::install
    include php-fpm::configure
    include php-fpm::run
}
