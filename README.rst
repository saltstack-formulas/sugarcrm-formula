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
==========================

.. code-block:: yaml

    wordpress:
      wp-username: wordpressUserName
      wp-database: wordpressDatabaseName
      wp-passwords:
        wordpress: wordpressPassword
        root: wordpressDatabasePassword
