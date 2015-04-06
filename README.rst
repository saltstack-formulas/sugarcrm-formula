=================
wordpress-formula
=================

A saltstack formula to install and configure WordPress on Debian, Ubuntu, and RHEL.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``wordpress``
-------------

Install and configure WordPress

Pillar customizations:
======================

.. code-block:: yaml

    wordpress:
      wp-username: <your-wordpress-mysql-username>
      wp-database: <your-wordpress-database-name>
      wp-passwords:
        wordpress: <your-wordpress-mysql-user-password>

Formula Dependencies
====================

* `apache-formula <https://github.com/saltstack-formulas/apache-formula>`_
* `saltstack-mysql-formula <https://github.com/bechtoldt/saltstack-mysql-formula>`_
* `php-formula <https://github.com/saltstack-formulas/php-formula>`_

Author
======

Nitin Madhok nmadhok@g.clemson.edu
Debian Fork by Starchy Grant starchy@gmail.com
