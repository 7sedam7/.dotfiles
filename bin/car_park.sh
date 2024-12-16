car_plate=""

token=$(curl -s \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-X POST -d "{ \"kiosk_hash\": \"4466c834d483a10a26b7\" }" https://partner.europark.ee/admin/api/login \
| sed -n 's|.*"token":"\([^"]*\)".*|\1|p')

curl -s \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-H "Authorization: Bearer $token" \
-X POST -d "{ \"vehicle_reg\": \"$car_plate\", \"language\": \"en\" }" https://partner.europark.ee/admin/api/kiosk/check

