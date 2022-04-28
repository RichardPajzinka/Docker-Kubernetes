docker pull mysql:8.0.22
docker pull sanomar/testapi_api
kubectl create namespace app
kubectl apply -f deploymentmysql.yaml -n app
kubectl apply -f statefulset.yaml -n app
kubectl apply -f configmap.yaml -n app
