# Ensure minikube has enough RAM for running Prometheus & Grafana
minikube stop
minikube start --memory 4gb
# Install Helm
./get_helm.sh
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo update
# Add namespace for prometheus and grafana
kubectl create namespace monitoring
helm install prometheus-operator stable/prometheus-operator --namespace monitoring
# Apply manifests for setting up nodeport services (used so we can access the apps on minikube)
kubectl apply -f ./manifests
# Enable the services through minikube
minikube service alertmgr-svc-for-minikube -n monitoring
minikube service grafana-svc-for-minikube -n monitoring
minikube service prometheus-svc-for-minikube  -n monitoring
