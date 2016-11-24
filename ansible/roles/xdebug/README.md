Xdebug for php5.x version
=========

Install Xdebug only for php5.x version.

Requirements
------------

Ubuntu trusty with the package python-pycurl and python-software-properties installed.

Role Variables
--------------

Available variables are listed below, along with default values (see [defaults/main.yml](defaults/main.yml)):

    xdebug_template_src_file: xdebug.ini.j2 # Path of a Jinja2 formatted template on the local server. This can be a relative or absolute path.
    xdebug:
      remote_port: 9000
      remote_host: 10.0.77.1

Dependencies
------------

- [PHP5](https://gitlab.mobidev.biz/ansible/php5-ubuntu)

License
-------

MIT

Author Information
------------------

[MobiDev](http://mobidev.biz/).
