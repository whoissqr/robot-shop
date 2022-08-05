# Seeker K8s Agent injector

Follow these steps to install the Agent Injector to your cluster:

1. Download & extract the Agent Injector package from the Seeker Server:
   ```
   curl -k -o /tmp/seeker-k8s-agent-injector.zip "${SEEKER_SERVER_URL}/rest/ui/installers/integrations/kubernetes"
   unzip -d seeker-k8s-agent-injector /tmp/seeker-k8s-agent-injector.zip
   ```
2. Navigate to extracted folder:
   ```
   cd seeker-k8s-agent-injector
   ```
3. Build & publish the admission controller docker image using your private registry (replace `seeker-local` with your registry):
   ```
   export DOCKER_REGISTRY=seeker-local
   docker build -t "${DOCKER_REGISTRY}/seeker-k8s-agent-injector:2022.8.0-SNAPSHOT" .
   docker push "${DOCKER_REGISTRY}/seeker-k8s-agent-injector:2022.8.0-SNAPSHOT"
   ```
4. Update your environment settings in `deploy/webhook.yaml`:  
   * Update `SEEKER_SERVER_URL` to point to your Seeker Server.
   * Update `image` with your registry prefix.  
5. Install the Agent Injector in your cluster:
   ```
   ./deploy-seeker-agent-injector.sh
   ```

The controller is pre-configured to use the namespace name as the composite project key and the container name as the project key. These can be easily modified to suite you deployment architecture by using the configuration variables that are commented in `deploy/webhook.yaml`.