#!/bin/sh

year=`date +%G`
month=`date +%m`
day=`date +%d`

echo "Today is $year / $month / $day"

if [ ! -d "$year" ]; then
    mkdir $year
    mkdir $year/images
    cd $year
    ln -s ../images/amazon-logo.eps .
    ln -s ../images/amazon-logo.png .
    ln -s ../src/sloglog.sty .
    ln -s ../src/clean.sh clean
    ln -s ../src/compile-today.sh compile-today
    cd ..
fi

if [ -d "$year" ]; then
    echo "Adding new entry to directory $year."
fi

cd $year
filename=$year-$month-$day.tex

if [ -f "$filename" ]; then
    echo "A file called '$filename' already exists in diretory $year. Aborting addition of new entry."
    exit
fi

cp ../src/entry.tex $filename

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

echo "Finished adding $filename to $year."
