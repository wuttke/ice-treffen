for START in `cut -f2 -d, stations_home.txt`
do
	for TARGET in `cut -f2 -d, stations_include_sorted.txt`
	do
		echo "Query: $START $TARGET"
		if [ ! -f journeys/$START-$TARGET.json ]
		then
			. hafas_request.sh $START $TARGET
		else
			echo "Existing"
		fi
	done
done

