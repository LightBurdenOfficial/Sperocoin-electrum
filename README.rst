Official Sperocoin Electrum Client - reference implementation
------------------------------------------------------------

-  Licence: GNU GPL v3
-  Author: Thomas Voegtlin
-  Author: SperoCoin Developers forked for Sperocoin
-  Language: Python
-  Homepage: https://sperocoin.org

Getting Started
---------------

Create the icons

::

    pyrcc4 icons.qrc -o gui/qt/icons_rc.py

To install the wallet and all its dependencies, just do:

::

    sudo python setup.py install

If ``setup.py`` fails with "ImportError: No module named setuptools",
install python-setuptools and run setup.py again

::

    sudo apt-get install python-setuptools python-dev
    sudo python setup.py install

Then you can run it from any directory:

::

    sperocoin-electrum

Or you can run it from the source code directory:

::

    ./sperocoin-electrum

Install in a Virtualenv (advanced)
----------------------------------

This is a more advanced setup where you install the client not to your
system but only to it's own private Python container. You can also do
this as a regular user, no need for root, except if you need to install
PyQt4 to the system (see below)

Somewhere create a virtualenv and enter it

::

    virtualenv electrum -p python2.7
    source electrum/bin/activate

Install dependencies

::

    pip install ecdsa pbkdf2 requests pyasn1 pyasn1-modules qrcode tlslite numpy SocksiPy-branch

PyQt4 is not available from pip and it is a PITA to build yourself
anyway, install it through your distribution and link it into the
virtualenv folder. Note that the system path of the libraries might be
different on your distribution.

On Ubuntu:

::

    sudo apt-get install python-qt4

On Gentoo:

::

    ln -s /usr/lib/python2.7/site-packages/sip* $VIRTUAL_ENV/lib/python2.7/site-packages/
    ln -s /usr/lib/python2.7/site-packages/PyQt4 $VIRTUAL_ENV/lib/python2.7/site-packages/

Create the icons

::

    pyrcc4 icons.qrc -o gui/qt/icons_rc.py

Install Sperocoin Electrum

::

    python setup.py install

How to Create Official Packages
-------------------------------

On Linux:

::

    python setup.py sdist --format=gztar

On Windows:

::

    export VERSION=2.0.0
    pyinstaller windows.spec
    zip -r dist/sperocoin-electrum-$VERSION-win.zip dist/sperocoin-electrum.exe

On Mac OS X:

::

    export VERSION=2.0.0
    pyinstaller macosx.spec
    sudo hdiutil create -fs HFS+ -volname "Sperocoin Electrum" -srcfolder "dist/Sperocoin Electrum.app" dist/sperocoin-electrum-$VERSION-mac.dmg

