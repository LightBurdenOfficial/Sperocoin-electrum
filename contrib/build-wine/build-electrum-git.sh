#!/bin/bash

# You probably need to update only this link
ELECTRUM_GIT_URL=https://github.com/sperocoin-project/sperocoin-electrum.git
BRANCH=master
NAME_ROOT=sperocoin-electrum

# These settings probably don't need any change
export WINEPREFIX=/opt/wine-electrum
export SYSTEMROOT="C:\\"
PYHOME=c:/python27
PYTHON="wine $PYHOME/python.exe -OO -B"

# Let's begin!
cd `dirname $0`
set -e

cd tmp

if [ -d "sperocoin-electrum" ]; then
    # GIT repository found, update it
    echo "Pull"

    cd sperocoin-electrum
    git pull
    cd ..

else
    # GIT repository not found, clone it
    echo "Clone"

    git clone -b $BRANCH $ELECTRUM_GIT_URL
fi

cd sperocoin-electrum
COMMIT_HASH=`git rev-parse HEAD | awk '{ print substr($1, 0, 11) }'`
echo "Last commit: $COMMIT_HASH"
cd ..


rm -rf $WINEPREFIX/drive_c/sperocoin-electrum
cp -r sperocoin-electrum $WINEPREFIX/drive_c/sperocoin-electrum
cp sperocoin-electrum/LICENCE .

# Build Qt resources
wine $WINEPREFIX/drive_c/Python27/Lib/site-packages/PyQt4/pyrcc4.exe C:/sperocoin-electrum/icons.qrc -o C:/sperocoin-electrum/lib/icons_rc.py

# Copy ZBar libraries to electrum
#cp "$WINEPREFIX/drive_c/Program Files (x86)/ZBar/bin/"*.dll "$WINEPREFIX/drive_c/electrum/"

cd sperocoin-electrum
$PYTHON setup.py install

cd ../..

rm -rf dist/

# For building uncompressed directory of dependencies, run:
$PYTHON "C:/pyinstaller/pyinstaller.py" -a -y deterministic.spec

# For building NSIS installer, run:
wine "$WINEPREFIX/drive_c/Program Files/NSIS/makensis.exe" electrum.nsi

DATE=`date +"%Y%m%d"`
cd dist
mv sperocoin-electrum.exe $NAME_ROOT-$DATE-$COMMIT_HASH.exe
mv sperocoin-electrum $NAME_ROOT-$DATE-$COMMIT_HASH
mv sperocoin-electrum-setup.exe $NAME_ROOT-$DATE-$COMMIT_HASH-setup.exe
zip -r $NAME_ROOT-$DATE-$COMMIT_HASH.zip $NAME_ROOT-$DATE-$COMMIT_HASH
