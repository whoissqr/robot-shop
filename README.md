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
```

### build seeker agent inject image and push to repo
```
docker login registry.gitlab.com -u kk.shichao@gmail.com -p xxxyyyzzz
export DOCKER_REGISTRY=registry.gitlab.com/apac-sig-demo/deploy-scripts/seeker-k8s
docker build -t "${DOCKER_REGISTRY}/seeker-k8s-agent-injector:2022.8.0" .
docker push "${DOCKER_REGISTRY}/seeker-k8s-agent-injector:2022.8.0"
```

### add a docker reg secret
```
kubectl create secret docker-registry regcred \
--docker-server=registry.gitlab.com \
--docker-username=kk.shichao@gmail.com \
--docker-password=glpat-xxxxx \
-n seeker-agent-injector
```

### add regcred to [seeker-k8s-agent-injector/deploy/webhook.yaml](seeker-k8s-agent-injector/deploy/webhook.yaml#L18)
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: seeker-k8s-agent-injector-webhook
  namespace: seeker-agent-injector
  labels:
    app: seeker-k8s-agent-injector-webhook
spec:
  replicas: 1
  selector:
    matchLabels:
      app: seeker-k8s-agent-injector-webhook
  template:
    metadata:
      labels:
        app: seeker-k8s-agent-injector-webhook
    spec:
      imagePullSecrets:
        - name: regcred
      containers:
 ```
