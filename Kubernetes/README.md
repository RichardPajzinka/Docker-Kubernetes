--------------Opis čo robí aplikácia.------------------------------

Moja aplikacia ma za ulohu pomocou webapi zobraziť mysql databazu. Webapi - je rozhranie na programovanie aplikacii
pre webovy server alebo webovy prehliadač. Mysql je to relačna databaza ktora je open source, podporovana na viacerych 
platformach a je implementovany vo viacerych programovacich jazykoch ako PHP, C++....

--------------Zoznam použitých kontajnerov a ich stručný opis.-------------

zoznam containerov - 
k8s_api-container_api-deployment
k8s_mysql_deplyment-mysql

my sql container v našom pripade sluzi na uchovanie dat ako databaza ku ktorej nemame priamy pristup ale pristupujeme 
k nej pomocou webapi a to vdaka tomu že tento kontajner ma k nej pristup . kontajner api aj my sql maju cluster IP
tym vieme povedat že su v rovnakej sieti inak povedane volume. Mena a hesla sa kontroluju automaticky pri vstupe taže
ich netreba zadat na login ale v deplymente ich treba spravne nastavit medzi sebou.

--------------Zoznam Kubernetes objektov a ich stručný opis----------------

Deployment - sa použiva na informovanie systemu Kubernetes o tom, ako ma vytvoriť alebo upraviť inštancie podov
v ktorych sa nachadza kontajnerova aplikacia, v našej aplikacii využivame:
deployment.yaml
deploymentmysql.yaml - Pripojenie zvazku sa použiva na pripojenie kontajnera na zadanu cestu. Kontajner MySQL pripoji
PersistentVolume na (/var/lib/mysql). a inicializačny skript na vytvorenie tabuľky MySQL je pripojeny na toto miesto
(/docker-entrypoint-initdb.d)
nazvy deplymentov :
deployment.apps/api-deployment
deployment.apps/deplyment-mysql

Service - Každe nasadenie Kubernetes musi byť umiestnene za servicom. Service možno definovať ako logicku sadu podov.
Pretože pody su dynamicke a často sa menia. Je doležite poskytnuť stabilne rozhranie k množine podov, ktore sa nemeni.
využivame :
service.yaml
Vytvarame :
service/api-service - Typ LoadBalancer Service je rozširenim typu NodePort, ktory je rozširenim typu ClusterIP.
service/mysql-service - vystavuje službu na statickom porte na IP adrese uzla. NodePorty su v predvolenom nastaveni
v rozsahu 30000-32767

Statefulset - Persistante volume je fyzicky zväzok na hostiteľskom počitači, ktory uchovava trvale udaje.
Žiadosť o trvaly zväzok Persistance volume claim, aby nam platforma vytvorila trvaly volume, a potom sa persistante volume
pripajaju k podom prostredníctvom persistane volume claim. Aby ste teda mohli vytvoriť trvaly volume, musite vytvoriť 
požiadavku na trvalý zväzok.Na konci suboru statefulset.yaml použivame configMap na uloženie inicializačneho skriptu 
MYSQL na vytvorenie tabuľky Pouzivateldb.ConfigMap je objekt API, ktory umožňuje uložiť konfiguraciu pre ine objekty
ktore sa maju použiť.

--------------Opis virtuálnych sietí a pomenovaných zväzkov ktoré aplikácia využíva.------

Volume mount sa používa na pripojenie containera na zadanú cestu. Kontajner MySQL pripojí PersistentVolume na 
(/var/lib/mysql). a inicializačný skript na vytvorenie tabuľky MySQL je pripojený na toto miesto(/docker-entrypoint-initdb.d)

---------------Opis konfigurácie kontajnerov ktorú ste vykonali.--------------------------

Klasicke nastavenie mena , použitie obrazu kde je špecifikovane ImagePullPolicy -t o znamena, že Kubernetes by sa nemal 
pokušať stiahnuť image z docker hubu, ale mal by použiť lokalny image preto sme v prepare stahovali image. port - to je 
čislo portu na ktorom bude pod bežat , replicas - Toto je počet podov, ktore by sa mali vytvoriť z tohto nasadenia. 
Repliky nam umožnuju ľahko škalovať naše pody a nakoniec aj našu aplikáciu , env taže hodnoty ktore sme si mohli vytvorit
a s ktorymi budeme pristupovat. V stateful.yaml sme využili ReadWriteOnce - Ak potrebujete zapisovať na volume, ale nemáte 
požiadavku, aby naň mohlo zapisovať viacero podov. My máme len jeden pod MYSQL, takže používame tento spôsob.

---------------Návod ako pripraviť, spustiť, pozastaviť a vymazať aplikáciu.---------------

Na začiatku je potrebne použit prikaz 
/prepare-app.sh
ktory nam pripravi našu apliakciu, stiahen image a nastavi stateful a namespace.

/start-app.sh
ktora využiva deplymenty pre webapi a mysql a taktiež service ktore su k tomu.

/stop-app.sh
to nam vymaže objekty a teda aplikacia sa zastavi ale nevymaže sa jej obsah

/remove-app.sh
tymto vymažeme cely namespace do ktoreho sme všetko vytavrali a taktiež vymažeme image ktore sme stiahli z prepare-app.sh

-----------Návod ako si pozrieť aplikáciu na webovom prehliadať.----------------------------

apliakcia kedže sme využili existujuci webapi tak ked všetko spustime a prejdeme na localhost:30808/swagger/ tak sa nam 
zobrazi stranka cez ktoru si vieme pozriet v sekcii User pozriet či to čo sme zadali sa nam zobrazi. Kedže stranka nie je 
primarne len na to určena ale aj na vela inych veci tak preto su tam aj dalšie možnosti ale kedže ja som ju využil iby na toto 
tak preto nam to vie zobrazit. všetky veci vdaka ktorym sa mi poradilo cele toto zostavit su z :

cviceni zkt -
https://student.kemt.fei.tuke.sk/zkt/home
docker hubu  -
https://hub.docker.com/_/mysql
https://hub.docker.com/r/sanomar/testapi_api
k tomu kedže je malo jasna dokumentacia vela som našiel cez fora a youtube videa.
https://stackoverflow.com/questions/57798267/kubernetes-persistent-volume-access-modes-readwriteonce-vs-readonlymany-vs-read
https://www.youtube.com/watch?v=Krpb44XR0bk




