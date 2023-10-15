for START in `cut -f2 -d, stations_home.txt`
do
for TARGET in `cut -f2 -d, stations_include_sorted.txt`
do
echo "Query: $START $TARGET"
. hafas_request.sh $START $TARGET
done
done

