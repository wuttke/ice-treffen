cat stations.json | jq -r '.result[] | [ .name, .evaNumbers[0].number ] | @csv' > stations_eva.txt

