## sample deployment to KIND


### create a KIND cluster
```
kind create cluster --name seeker-inj
```

### test helm chart
```
git clone https://github.com/instana/robot-shop
cd robot-shop/K8s/helm
helm install  robot-shop --namespace robot-shop .
helm ls -A
```

### download agent injector
```
cd robot-shop
export SEEKER_SERVER_URL=http://prd-sal-demo01.dc2.lan:8080
curl -k -o /tmp/seeker-k8s-agent-injector.zip "${SEEKER_SERVER_URL}/rest/ui/installers/integrations/kubernetes"
unzip -d seeker-k8s-agent-injector /tmp/seeker-k8s-agent-injector.zip
cd seeker-k8s-agent-injector/

docker login registry.gitlab.com -u kk.shichao@gmail.com -p xxxyyyzzz
export DOCKER_REGISTRY=registry.gitlab.com/apac-sig-demo/deploy-scripts/seeker-k8s
docker build -t "${DOCKER_REGISTRY}/seeker-k8s-agent-injector:2022.8.0" .
docker push "${DOCKER_REGISTRY}/seeker-k8s-agent-injector:2022.8.0"
```
