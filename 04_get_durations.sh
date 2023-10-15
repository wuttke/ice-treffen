rm -f durations.txt
for START in `cut -f2 -d, stations_home.txt`
do
for TARGET in `cut -f2 -d, stations_include_sorted.txt`
do

DURATION=$(cat journeys/${START}-${TARGET}.json | jq '.routes[].duration' |sort|head -n1)
echo $START,$TARGET,$DURATION >> durations.txt

done
done

