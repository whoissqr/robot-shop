## sample deployment to KIND


## create a KIND cluster
kind create cluster --name seeker-inj

## deploy helm chart

git clone https://github.com/instana/robot-shop
cd robot-shop/K8s/helm
helm install  robot-shop --namespace robot-shop .
helm ls -A


