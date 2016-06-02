=================
sugarcrm-formula
=================

A saltstack formula to install and configure sugarcrm on Debian, Ubuntu, and RHEL.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``sugarcrm``
-------------

Install and configure sugarcrm sites

``sugarcrm.cli``
-------------

Installs wp-cli


``sugarcrm.config``
-------------

Configure sugarcrm sites

Pillar customizations:
======================

.. code-block:: yaml

    sugarcrm:
        sites:
            sitename:
              username: <your-sugarcrm-username>
              password: <your-sugarcrm-user-password>
              database: <your-sugarcrm-database-name>
              dbuser: <your-sugarcrm-db-username>
              dbpass: <your-sugarcrm-db-password>       
              url: http://example.ie
              title: 'My Blog'
              email: 'john.doe@acme.com'       

Formula Dependencies
====================

* `apache-formula <https://github.com/saltstack-formulas/apache-formula>`_
* `php-formula <https://github.com/saltstack-formulas/php-formula>`_

or

* `nginx-formula <https://github.com/saltstack-formulas/nginx-formula>`_
* `php-formula <https://github.com/saltstack-formulas/php-formula>`_

Author
======

Nitin Madhok nmadhok@g.clemson.edu
Debian Fork by Starchy Grant starchy@gmail.com
