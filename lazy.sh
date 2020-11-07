#!/bin/bash

#hw 2

select=$1
move="move"
delete="delete"
copy="copy"
create="create"

echo "$select was selected"

if [ $select == $move ]; then
    echo "which file?"
    read filename
    echo "where to?"
    read path
    echo mv $filename $path
    exit
elif [ $select == $delete ]; then
    echo "which file?"
    read filename
    rm -rf $filename
    exit
elif [ $select == $copy ]; then
    echo "which file?"
    read filename
    echo "where to?"
    read filename2
    echo cp $filename $filename2
    exit
elif [ $select == $create ]; then
    echo "which file?"
    read filename
    touch $filename
    exit
else
    echo "Wrong key"
    exit
fi
