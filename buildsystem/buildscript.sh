#!/bin/bash

MAINDIR=buildtmp/${OXPNAME}_$VERSION
OXPDIR=buildtmp/${OXPNAME}_$VERSION/${OXPNAME}_$VERSION.oxp
TESTDIR=~/.Oolite/AddOns/${OXPNAME}.oxp
TESTFILE=~/.Oolite/AddOns/${OXPNAME}.oxz
DISTFILE=${OXPNAME}_$VERSION.zip
OXZFILE=${OXPNAME}_$VERSION.oxz
YEAR=`date +%Y`

rm -rf ${DISTFILE} ${OXZFILE} buildtmp
mkdir -p buildtmp
cat buildsystem/scriptheader.js \
  | sed -e "s/VERSION/${VERSION}/" \
  | sed -e "s/AUTHOR/${AUTHOR}/" \
  | sed -e "s/LICENSE/${LICENSE}/" \
  | sed -e "s/YEAR/2011-${YEAR}/" \
  > buildtmp/scriptheader.js

mkdir -p $MAINDIR
mkdir -p $OXPDIR

cp -r oxp/* $OXPDIR

if [ -f oxp/manifest.plist ] ; then
	cat oxp/manifest.plist \
	| sed -e "s/\"version\"\s*=.*/\"version\" = \"${VERSION}\";/" \
	| sed -e "s/\"author\"\s*=.*/\"author\" = \"${AUTHOR}\";/" \
        | grep -v "download_url" \
        | grep -v "file_size" \
        | grep -v "upload_date" \
        > ${OXPDIR}/manifest.plist
fi

cat ${OXPDIR}/manifest.plist

find $MAINDIR -name \*~ -delete
if [ -d $OXPDIR/Scripts ] ; then
	find $OXPDIR/Scripts -name \*.js -exec ./buildsystem/buildjs.sh '{}' ';'
fi

pushd .
cd ${OXPDIR}
zip -9rq ../../$OXZFILE *
popd
