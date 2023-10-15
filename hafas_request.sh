START=$1
TARGET=$2

mkdir -p journeys

echo "Query $START to $TARGET"
# 8000107 8000240

curl \
	-X POST \
	-H "Content-Type: application/json" \
	-d "{\"time\":\"2023-10-18T12:20:53.589Z\",\"searchForDeparture\":true,\"start\":\"$START\",\"destination\":\"$TARGET\",\"via\":[],\"maxChanges\":\"-1\",\"transferTime\":\"0\",\"onlyRegional\":false,\"onlyNetzcard\":false,\"hafasProfile\":\"db\"}" \
	https://bahn.expert/api/hafas/v3/tripSearch > journeys/${START}-${TARGET}.json

echo "Done."

