=================
sugarcrm-formula
=================

A saltstack formula to install and configure SugarCRM, a customer relationship management (CRM) system.

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

Installs sugarcli


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

