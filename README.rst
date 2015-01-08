wordpress
=========

Available states
================

.. contents::
    :local:

``wordpress``
-------------

Install and configure wordpress

Pillar customizations:
======================

.. code-block:: yaml

    wordpress:
      wp-username: wordpressUserName
      wp-database: wordpressDatabaseName
      wp-passwords:
        wordpress: wordpressPassword
        root: wordpressDatabasePassword

Formula Dependencies
====================

* `apache-formula <https://github.com/saltstack-formulas/apache-formula>`_
* `mysql-formula <https://github.com/saltstack-formulas/mysql-formula>`_
* `php-formula <https://github.com/saltstack-formulas/php-formula>`_

Author
======

Nitin Madhok nmadhok@g.clemson.edu
