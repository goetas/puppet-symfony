class php-cli::install {
    package { 'php5-cli':
        ensure => installed
    }
    package { 'php5-sqlite':
        ensure => installed
    }
    package { 'php5-intl':
        ensure => installed
    }
    package { 'php5-json':
        ensure => installed
    }    
    package { 'php5-curl':
        ensure => installed
    }
    package { 'php5-apcu':
        ensure => installed
    }
    package { 'php5-gd':
        ensure => installed,
        require => Class['php-cli']
    }    
}

class php-cli::configure {
    exec { 'php-cli-set-timezone':
        path => '/usr/bin:/usr/sbin:/bin',
        command => 'sed -i \'s/^[; ]*date.timezone =.*/date.timezone = Europe\/London/g\' /etc/php5/cli/php.ini',
        onlyif => 'test "`php -c /etc/php5/cli/php.ini -r \"echo ini_get(\'date.timezone\');\"`" = ""',
        require => Class['php-cli::install']
    }
    exec { 'php-cli-disable-short-open-tag':
        path => '/usr/bin:/usr/sbin:/bin',
        command => 'sed -i \'s/^[; ]*short_open_tag =.*/short_open_tag = Off/g\' /etc/php5/cli/php.ini',
        onlyif => 'test "`php -c /etc/php5/cli/php.ini -r \"echo ini_get(\'short_open_tag\');\"`" = "1"',
        require => Class['php-cli::install']
    }
}

class php-cli {
    include php-cli::install
    include php-cli::configure
}
