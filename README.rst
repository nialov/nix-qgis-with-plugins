qgis-with-plugins
=================

This is a draft to package ``QGIS`` along with pre-installed plugins
using ``nix``.

To build remotely using ``nix`` with flakes enabled:

.. code:: bash

   nix build github:nialov/qgis-with-plugins

To build after cloning:

.. code:: bash

   nix build .#
