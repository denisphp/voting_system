MariaDB
=========

Install MariaDB 10.1 version.

Requirements
------------

Ubuntu trusty with the package python-pycurl and python-software-properties installed.

Role Variables
--------------

Available variables are listed below, along with default values (see [defaults/main.yml](defaults/main.yml) ):

    maria_config_src_file: my.cnf.j2 # Path of a Jinja2 formatted template on the local server. This can be a relative or absolute path.
    maria_root_pass_config_src_file: root_pass_my.cnf.j2 # Path of a Jinja2 formatted template on the local server. This can be a relative or absolute path.
    mariadb:
        root_password: mysecretrootpass
        user: myapp
        password: mysecretpass
        databases: [
            myapp
        ]

Dependencies
------------

None.

License
-------

MIT

Author Information
------------------

[MobiDev](http://mobidev.biz/).
