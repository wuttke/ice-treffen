. credentials.sh
echo "Client-ID: $CLIENT_ID"

curl https://apis.deutschebahn.com/db-api-marketplace/apis/station-data/v2/stations?category=1-2 \
  -H "Accept: application/json" \
  -H "DB-Client-Id: $CLIENT_ID" \
  -H "DB-Api-Key: $CLIENT_SECRET" > stations.json

