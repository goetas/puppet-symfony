class ubuntu {
    exec { 'apt-get-update':
        path => '/usr/bin',
        command => 'apt-get update && touch /tmp/apt-get-update',
        onlyif => 'test ! -e /tmp/apt-get-update || test -z `find /tmp/apt-get-update -mmin -1440`'
    }
}
