#!/bin/bash

for file in $(rg -l $1 .)
do
  sed -e "s/$1/$2/ig" $file > tempfile.tmp
  mv tempfile.tmp $file

  echo "Modified: $file"
done

echo "Done."
