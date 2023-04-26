#!/bin/bash
filepath=$(cd "$(dirname "$0")"; pwd)

cd "$filepath"

# projects=$(ls PWManager/OOG104)

read_dir(){
    for i in `find $1"/$2""/Assets.xcassets" -name "*.imageset" -exec basename {} \; | sed 's;.imageset;;'`
     do
       echo $i
     done 
}

for dir in `ls PWManager/Assets/OOG104`
do
  read_dir PWManager/Assets/OOG104 $dir 
done 