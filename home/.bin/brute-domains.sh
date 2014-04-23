#!/usr/bin/env bash

if [ -z "$1" ] ; then
    echo "Domain to brute force required."
    exit 1
fi

walk_alphanumeric.rb | parallel -j100 dig +noall {}.$1 +answer
