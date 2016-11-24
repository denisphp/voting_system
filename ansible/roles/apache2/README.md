Apache2
=========

Install apache2.

Requirements
------------

Ubuntu trusty with the package python-pycurl and python-software-properties installed.

Role Variables
--------------

Available variables are listed below, along with default values (see [defaults/main.yml](defaults/main.yml)):

    apache_servername_src_file: servername.j2 # Path of a Jinja2 formatted template on the local server. This can be a relative or absolute path.
    apache_ports_src_file: ports.conf.j2 # Path of a Jinja2 formatted template on the local server. This can be a relative or absolute path.
    apache_default_virtualhost_src_file: default_virtualhost.j2 # Path of a Jinja2 formatted template on the local server. This can be a relative or absolute path.
    apache_install_modules:
      - libapache2-mod-php5
    #  - libapache2-mod-php7.0 # for php 7.0
      - libapache2-mod-xsendfile
    
    apache_enable_modules:
      - ssl
      - rewrite
      - xsendfile
    
    apache_run_user: 'www-data'
    apache_run_group: 'www-data'
    apache_server_name: 'localhost'
    default_apache_document_root: '/var/www'
    # Param `template` at `apache_vhosts` or `apache_ssl_vhosts` - path of a Jinja2 formatted template on the local server.
    # This can be a relative or absolute path WITHOUT `.j2` prefix
    apache_vhosts: [
        { name: 'local', port: '80', root: '/var/www', email: 'admin@localhost', template: 'virtualhost' },
        { name: 'db.local', port: '80', root: '/usr/share/phpmyadmin', email: 'admin@localhost', template: 'phpmyadmin' }
    ]
    apache_ssl_vhosts: [] # like: { name: 'local', root: '/var/www', email: 'admin@localhost', template: 'ssl_virtualhost' },
    ssl_certs_folder: '/etc/apache2/ssl/certs/'
    ssl_certs_files: [
          certs/server.cer,
          certs/server.csr,
          certs/server.key,
          certs/CA_bundle.pem,
    ]
    ssl_certificate_file: 'server.cer'
    ssl_certificate_key_file: 'server.key'
    ssl_certificate_chain_file: 'CA_bundle.pem'

Don't use libapache2-mod-php5 for php7.0

    apache_install_modules:
          #- libapache2-mod-php5
          - libapache2-mod-php7.0 # for php 7.0

apache_ssl_vhosts for example:

    apache_ssl_vhosts: [
        { name: 'local', root: '/var/www', email: 'admin@localhost', template: 'ssl_virtualhost' }
    ]

Param `template` at `apache_vhosts` or `apache_ssl_vhosts` - path of a Jinja2 formatted template on the local server. This can be a relative or absolute path **WITHOUT** `.j2` prefix

Dependencies
------------

None.

License
-------

MIT

Author Information
------------------

[MobiDev](http://mobidev.biz/).