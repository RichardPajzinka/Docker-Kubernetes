docker rm phpmyadmin
docker rm mariadb
docker volume rm database
docker network rm myapp
docker image rm mariadb:10.6.4
docker image rm phpmyadmin/phpmyadmin:latest
