docker run --name mariadb -v database:/app --network myapp --restart always -e MARIADB_ROOT_PASSWORD=zkt22 -d mariadb:10.6.4
docker run --name phpmyadmin --network myapp --restart always -d --link mariadb:db -p 8081:80 phpmyadmin/phpmyadmin
echo "localhost:8081"
echo "Username: root; Password :zkt22"
