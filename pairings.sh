#!/bin/bash
urx="Last Updated: 2019-[0-9]{2}-[0-9]{2} ([0-9]{1,2}:[0-9]{2}[ap]m)"
trx="([0-9]{1,2}):([0-9]{2})([ap]m)"
prx="<tr[^>]*> <td>([0-9]+)</td> <td><a href=\"http://pairings.channelfireball.com/personal/124/[0-9]*\">Shmoe, Joe</a></td> <td>[0-9]*</td> <td><a href=\"http://pairings.channelfireball.com/personal/128/[0-9]*\">([^<]+)</a></td> </tr>"
last="6:19am"
lhrs=18
lmins=19
rd=4

sleep 3000
while [ 1 ];
do
  content=`curl -s "http://pairings.channelfireball.com/pairings/128"`
  if [[ $content =~ $urx ]]; then
    updated="${BASH_REMATCH[1]}"
    if [ "$last" != "$updated" ] && [[ $updated =~ $trx ]]; then
      hrs="${BASH_REMATCH[1]}"
      mins="${BASH_REMATCH[2]}"
      ampm="${BASH_REMATCH[3]}"
      if [ "$ampm" = "pm" ] && [ "$hrs" -lt 12 ]; then
        hrs=$((hrs + 12))
      fi
      elapsed=$((60 * (hrs - lhrs) + mins - lmins))
      if [ "${elapsed#-}" -gt 50 ] && [[ $content =~ $prx ]]; then
        echo $elapsed " minutes elapsed between pairings"
        lhrs=$hrs
        lmins=$mins
        last=$updated
        msg="Table ${BASH_REMATCH[1]} - ${BASH_REMATCH[2]}"
        curl -X POST https://textbelt.com/text \
        --data-urlencode phone="0000000000" \
        --data-urlencode message="${msg}" \
        -d key=token_goes_here
        echo
        echo "Sent round ${rd} pairing: ${msg}"
        if [ "$rd" -eq 9 ]; then
          exit 0
        elif [ "$rd" -eq 12 ]; then
          echo "Waiting on round ${rd} and second draft to finish..."
          sleep 7200
        else
          sleep 3900
          echo "Waiting on round ${rd} to finish..."
        fi
        rd=$((rd + 1))
      fi
    fi
  else
    echo "ERROR: failed to parse update time"
    exit 1
  fi
  echo "Waiting to recheck..."
  sleep 20
done
