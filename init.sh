docker-compose down 1>/dev/null 2>&1
docker-compose up -d

./create-topic.sh ORDER 3 1
./create-topic.sh ORDER-MAIL 3 1

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

./gradlew run






