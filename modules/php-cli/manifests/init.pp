class php::install-cli {
    package { 'php5-cli':
        ensure => installed
    }
    package { 'php5-sqlite':
        ensure => installed
    }
    package { 'php5-intl':
        ensure => installed
    }
    package { 'php-apc':
        ensure => installed
    }
    package { 'php-pear':
        ensure => installed
    }
}

class php::configure-cli {
    exec { 'set-timezone':
        path => '/usr/bin:/usr/sbin:/bin',
        command => 'sed -i \'s/^[; ]*date.timezone =.*/date.timezone = Europe\/London/g\' /etc/php5/cli/php.ini',
        onlyif => 'test "`php -r \"echo ini_get(\'date.timezone\');\"`" = ""',
        require => Class['php::install-cli']
    }
    exec { 'disable-short-open-tag':
        path => '/usr/bin:/usr/sbin:/bin',
        command => 'sed -i \'s/^[; ]*short_open_tag =.*/short_open_tag = Off/g\' /etc/php5/cli/php.ini',
        onlyif => 'test "`php -r \"echo ini_get(\'short_open_tag\');\"`" = "1"',
        require => Class['php::install-cli']
    }
}

class php-cli {
    include php::install-cli
    include php::configure-cli
}
