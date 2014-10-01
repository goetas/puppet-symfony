stage { 
    'prepare':
}
stage { 
    'mio':
}
stage { 
    'prepareenv':
}

Stage['prepare'] -> Stage['prepareenv'] ->  Stage['main']


class {
    'ubuntu':  stage => prepare;
    
    'dev':     stage => prepareenv;
    
    'php-cli': stage => main;
    'php-dev': stage => main;
    #'php-fpm': stage => main;
    
    'apache':   stage => main;
    
}

apache::vhost { 'sito':
    site => 'sito',
    server_name => 'dominio',
    docroot => '/vagrant/projects/folder/web'
}

