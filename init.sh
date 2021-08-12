# Removes dangling images
docker image rm -f $(docker images -f "dangling=true" | awk 'NR > 1 { image=image $3 " " } END { print image }')  1>/dev/null 2>&1

# Cleans existing data
./gradlew clean 1>/dev/null 2>&1

# Compiles and generates a new Jar
./gradlew fatJar 1>/dev/null 2>&1

# Down and remove containers
docker-compose down 1>/dev/null 2>&1

# Build the application image without cache(builds everytime)
docker-compose build --no-cache

# Up the containers, and scales the application with three instances
docker-compose up -d --scale application=3

echo "Containers are starting ..."

# Sleeps thirty seconds
sleep 30

# Produces initial data ...
./produce-customer.sh 1 'Matheus Rambo' mrambo@grupodimed.com.br
./produce-customer-address.sh 1 'ELDORADO'

./produce-customer.sh 2 'Douglas Sairone' dsirone@grupodimed.com.br
./produce-customer-address.sh 2 'PORTO ALEGRE'

./produce-customer.sh 3 'Raphael Monteiro' rmonteiro@grupodimed.com.br
./produce-customer-address.sh 3 'Porto Alegre'

./produce-customer.sh 4 'Ricardo Santos' rsantos@uol.com.br
./produce-customer-address.sh 4 'Santos'

./produce-item.sh 1 'Fralda' 12.25
./produce-item.sh 2 'Pilhas Duracell' 3.25
./produce-item.sh 3 'Leite' 3.48







