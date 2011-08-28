SpreeMultiVendor
================

This extension allows a single Spree instance to run multi stores for different vendors (i.e. multi-store, mulit-vendor).

What this extension does is basically managing database connections, i.e. each store has its own database. This extension also add rake scripts to do migration on multiple databases.

You can have only one database in test and database environment.

Usage
=======

Add the key database_prefix on database.yml (production environment) as below:

    production:
        database_prefix: ecommerce_
        adapter: mysql2
        encoding: utf8
        reconnect: false
        pool: 5
        username: root
        password: xxxxxx

When the request comes in, it'll make the connection based on the domain name (eg. example.com). In this case, it'll connect to the database named "ecommerce_example_com". If that database doesn't exist, it'll render page not found.

There are three rake scripts available to do migration on multiple databases:

    rake multi:db:migrate (options: VERSION=x, VERBOSE=false)
    rake multi:db:migrate:up (options: VERSION=x, VERBOSE=false)
    rake multi:db:migrate:down (options: VERSION=x, VERBOSE=false)

Copyright (c) 2011 chamnap, released under the New BSD License
