#!/bin/bash
expected=outfile
for f in $@
do
  if [ "$expected" = outfile ]; then
      OUTFILE=$1
      expected=search
  elif [ "$expected" = search ]; then
      SEARCH=$2
      expected=files
  elif [[ -f $f ]]; then
      RESULT=`grep "$SEARCH" $f`
      if [ -n "$RESULT" ]; then
           echo -e "\n"
           echo "Error(s) in "$f":"
           echo $RESULT
           echo -e "\n" >> $OUTFILE
           echo "Error(s) in "$f":" >> $OUTFILE
           echo $RESULT >> $OUTFILE
      fi
  fi
done

#Invoke with "scriptname outfile search files"
#for example: "logcheck errorsfound.txt error /var/log/*.log
#to cron this for every day at 3PM: */15 * * * /path/to/script/location/logcheck.sh
#to cron this for once a week at 3PM on a monday: */15 * * 1 /path/to/script/location/logcheck.sh
