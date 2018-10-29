#!/bin/sh

year=`date +%G`
month=`date +%m`
day=`date +%d`

echo "$year/$month/$day"

if [ ! -d "$year" ]; then
    mkdir $year
fi

cd $year

if [ ! -d "$month" ]; then
    mkdir $month
    cd $month
    ln -s ../../src/sloglog.sty .
    ln -s ../../src/clean.sh clean
    mkdir images
    cd images
    ln -s ../../../images/amazon-logo.eps .
    ln -s ../../../images/amazon-logo.png .
    cd ..
fi

if [ -d "$month" ]; then
    echo "Adding new entry to directory $year/$month."
fi

filename=$year-$month-$day.tex

if [ -f "$filename" ]; then
    echo "A file called '$filename' already exists in directory $year/$month."
    exit
fi

cp ../../src/entry.tex $filename

platform=`uname`
if [[ "$platform" == 'Darwin' ]]; then
    sed -i "" "s/@year/$year/g" $filename
    sed -i "" "s/@MONTH/`date +%B`/g" $filename
    sed -i "" "s/@dday/$day/g" $filename
    sed -i "" "s/@day/`date +%e`/g" $filename
else
    sed -i "s/@year/$year/g" $filename
    sed -i "s/@MONTH/`date +%B`/g" $filename
    sed -i "s/@dday/$day/g" $filename
    sed -i "s/@day/`date +%e`/g" $filename
fi

echo "Created $filename in $year/$month."
