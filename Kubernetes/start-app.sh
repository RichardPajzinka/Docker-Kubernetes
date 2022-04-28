kubectl apply -f deployment.yaml -n app
kubectl apply -f service.yaml -n app
echo 'tym ze sme vyuzili api ktory ma v sebe aj nastavenu stranku mozeme teda pozriet vysledok na : localhost:30808/swagger/'