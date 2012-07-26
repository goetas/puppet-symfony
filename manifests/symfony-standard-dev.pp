stage { 'prepare': before => Stage['main'] }

class {
    'ubuntu':  stage => prepare;
    'php-cli': stage => main;
    'php-fpm': stage => main;
    'php-dev': stage => main;
    'nginx':   stage => main;
    'dev':     stage => main;
}
