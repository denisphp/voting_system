PhpMyAdmin
=========

Install PhpMyAdmin for Mysql/MariaDB.

Requirements
------------

Ubuntu trusty with the package python-pycurl and python-software-properties installed.

Role Variables
--------------

Available variables are listed below, along with default values (see [defaults/main.yml](defaults/main.yml) ):

    phpmyadmin_language: english #'english' or 'all-languages'
    web_server_run_user: www-data
    phpmyadmin_control_database: phpmyadmin
    phpmyadmin_mysql_host: localhost
    mysql_root_pass: password_for_your_mysql_root_user

Dependencies
------------

- [MySQL](https://gitlab.mobidev.biz/ansible/mysql)  
or  
- [MariaDB](https://gitlab.mobidev.biz/ansible/mariadb-10-1)

License
-------

MIT

Author Information
------------------

[MobiDev](http://mobidev.biz/).