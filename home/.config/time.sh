function time_func()
{
   date2=$((`date +%s` + $1));
   date1=`date +%s`;
   date_finish="$(date --date @$(($date2)) +%T )"

   echo "Start at `date +%T`   Will finish at $date_finish"

    while [ "$date2" -ne `date +%s` ]; do
     echo -ne "     Since start: $(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)     Till end:  $(date -u --date @$(($date2 - `date +%s`)) +%H:%M:%S)\r";
     sleep 1
    done

    printf "\nTimer finished!\n"
}

function time_seconds()
{
  echo "Counting to $1 seconds"
  time_func $1
}

function time_minutes()
{
  echo "Counting to $1 minutes"
  time_func $1*60
}

function time_hours()
{
  echo "Counting to $1 hours"
  time_func $1*60*60
}

function time_flexible()  # accepts flexible input hh:mm:ss
{
    echo "Counting to $1"
    secs=$(time2seconds $1)
    time_func $secs
}

function time2seconds() # changes hh:mm:ss to seconds, found on some other stack answer
{
    a=( ${1//:/ })
    echo $((${a[0]}*3600+${a[1]}*60+${a[2]}))
}
