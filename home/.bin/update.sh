#!/usr/bin/env sh

# How long to go between update checks
RECHECK_IN='1 week'

function reset_date() {
    echo "RECHECK_DATE=$(date +%s --date="$RECHECK_IN")" > ~/.update.rc
}

NOW=$(date +%s)

# If we don't have an update.rc, create it
if [ ! -f ~/.update.rc ] ; then
    reset_date
fi

. ~/.update.rc

if [ $NOW > $RECHECK_DATE ] ; then
    homeshick check
    brew update
    reset_date
fi
