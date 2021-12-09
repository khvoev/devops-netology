#!/bin/bash
# display command line options

count=1
for param in "$@"; do
    echo "Parameter: $param"
>>>>>>> c9e081c (git rebase 1)
    count=$(( $count + 1 ))
done

echo "====="