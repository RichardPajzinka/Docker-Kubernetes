--------------Podmienky na nasadenie a spustenie aplikácie - podrobný zoznam potrebného softvéru.-----------------------------------

Operačny system : Ubuntu 20.04.3 LTS
Program : Docker Desktop (aplikacia a nasadenie boli skušane na verzii : Docker Desktop 4.5.1 (74721))
Componenty ktore boli použite : MariaDB 10.6.4 , phpmyadmin

--------------Opis čo robí aplikácia.------------------------------------------------------------------------------------------------

Inštalacia relačnej databazy s webovym rozhranim.Pre pracu a spravovanie databaz.

MariaDB je komunitou vyvinutá, open source a komerčne podporovaná odnož relačného systému na správu databáz MySQL.
Vyvinul ho pôvodný tím zodpovedný za MySQL s kompromisom, aby zostal open source. Podporuje ju väčšina hlavných 
poskytovateľov cloudových služieb a je štandardne dostupná vo väčšine distribúcií Linuxu.

PhpMyAdmin je bezplatný softvérový nástroj napísaný v jazyku PHP, ktorého cieľom je poskytnúť ľahko použiteľné 
webové rozhranie na správu širokej škály operácií s databázami MySQL a MariaDB. Každodenné pracovné operácie
ako je správa databáz, tabuliek, stĺpcov, vzťahov, indexov, používateľov, oprávnení, možno vykonávať prostredníctvom 
používateľského rozhrania bez toho, aby ste prišli o možnosť vykonávať akýkoľvek príkaz SQL.

-------------Opis virtuálnych sietí a pomenovaných zväzkov ktoré aplikácia využíva.-----------------------------------------------------------

Aplikacia využiva Zvazok pomenovany ako - database - ktory sme vytovrili prikazom
docker volume create database(tento prikaz sa nachadza v prepare-app.sh). Vdaka tomu vieme zaručit to že 
data preťiju aj po reštarte daneho kontajnera ktory sa tam bude nachadzat v našom pripade to je mariadb

APlikacia využiva virtualnu siet - myapp - pomocou ktorej vedia dane kontajnery spolu komunikovat 

-------------Opis konfigurácie kontajnerov ktorú ste vykonali.--------------------------------------------------------------------------------

docker run --name mariadb -v database:/app --network myapp --restart always -e MARIADB_ROOT_PASSWORD=zkt22 -d mariadb:10.6.4

-- name nam umožnuje priradit konkretny nazov pre naš bežiaci kontajnera
-v volume a nazov do ktoreho ho chceme priradit
--network predstavuje siet do ktorej priradime tento kontajner 
--restart sposobi to že reštartuje dany kontajner a always znamena - ak sa kontajner zastavi vždy ho restartuje.
-e sa použiva na odovzdavanie hodnoty premennej prostredia , našom pripade je to password ktory si vyžiada kontajner na spravne spsutenie
-d znamena že docker spusti kontajner na pozdai, v pripade žeby sa d nepoužilo tak beži v predvolenom režime


docker run --name phpmyadmin --network myapp --restart always -d --link mariadb:db -p 8081:80 phpmyadmin/phpmyadmin

-- name nam umožnuje priradit konkretny nazov pre naš bežiaci kontajnera
--network predstavuje siet do ktorej priradime tento kontajner 
--restart sposobi to že reštartuje dany kontajner a always znamena - ak sa kontajner zastavi vždy ho restartuje.
-d znamena že docker spusti kontajner na pozdai, v pripade žeby sa d nepoužilo tak beži v predvolenom režime
--link poskytuje pristup k inemu kontajneru spustenemu v hostiteľovi názvom mariadb a prostriedok, ku ktoremu sa pristupuje, je db Mariadb.
-p za ktorou nasleduje čislo portu hostiteľa (8081), ktory bude presmerovany na čislo portu kontajnera 

------------Zoznam použitých kontajnerov a ich stručný opis.------------------------------------------------------------------------------------

mariadb,phpmyadmin

mariadb - kontajner na ktorom spustame image ktory sme stiahli z docker hubu.
phpmyadmin - prostredie cez ktore vieme spustit na webe mariadb 

-----------Návod ako pripraviť, spustiť, pozastaviť a vymazať aplikáciu.------------------------------------------------------------------------

1.krok 

Zapnutie windows terminal kde si dame šipku dole a vyberieme ubuntu. Spustit aplikaciu docker desktop. v ubuntu napisat "docker version"
pre zaručenie komunikacie ubuntu a docker desktop.

2.krok

Spustenie prepae-app.sh pomocou prikazu - ./prepare-app.sh ktory nam pripravy všetko potrebne stiahne obraz z docker hub a vytvori
volume a network

3.krok

Spustenie scriptu start-app.sh pomocou prikazu - ./start-app.sh ktory nam vytvori dane kontajnery ktore su opisane vyššie a taktiež nam vypiše
spravu na aky port sa vieme pripojit pomocou prehliadača a ake su pristupove udaje

4.krok 

Pozastavit aplikaciu vieme pomocou scriptu stop-app.sh - prikaz - ./stop-app.sh pozastavia sa kontajnre. V pripade žeby sme napisali prikaz
na pozastavenie iba mariadb tak sa zastavi kontajner mariadb čož bude viest k neprihlaseniu na stranku. V pripade že chceme aplikaciu vymazat
musime ju prv zastavit.

5.krok

Vymazat aplikaciu -remove-app.sh prikaz - ./remove-app.sh - Vymažu sa kontajnre potom sa vymažu volume a network a taktiež vymaže aj stiahnute
obrazy ktore sme stiahli v prepare pomocou prikazu pull.

-----------Návod ako si pozrieť aplikáciu na webovom prehliadať.----------------------------------------------------------------------------------

V pripade že sme spustil script na prepare a script pre start. Tak sa nam objavi port na ktory sa vieme prihlasit pomocou weboveho prehldiaca
taktiež nam vypiše aj meno a heslo pomocou ktoreho sa vieme dostat dovnutra. Kde vieme pomocou grafickeho prostredia vytvorit databazu ktora sa uloži 
aj po restarte kontajnera.

Web - 
https://hub.docker.com/_/mariadb
https://hub.docker.com/_/phpmyadmin