# MapR OpenShift documentation

https://app.dsri.unimaas.nl:8443/

vincent.emonet



## Install client

```shell
wget https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz

tar xvf openshift-origin-client-tools*.tar.gz
cd openshift-origin-client*/
sudo mv oc kubectl /usr/local/bin/
```

## Login

Login to the cluster using the OpenShift client
```shell
oc login https://openshift_cluster:8443 --token=MY_TOKEN
```

Get the command with the token from the `Copy Login Command` button in the user details at the top right of the OpenShift webpage.



## Argo

```shell
argo submit --watch d2s-sparql-workflow.yaml

# Define params in a separate YAML file (no _ in params name)
argo submit d2s-workflow-transform-xml.yaml -f workflow-params-drugbank.yml
```



## OC Run

### Pods

```shell
oc new-app --file=./example/myapp/template.json --param=MYSQL_USER=admin

oc create -f examples/hello-openshift/hello-pod.json

oc run nginx --image=nginx --overrides='{ "apiVersion": "v1", "spec": { ... } }'
oc run 
```

### Workflows

```shell
oc create -f d2s-sparql-workflow.yaml
```





## EXAMPLES

https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/



https://github.com/openshift/origin/blob/0d899cf42bd12faa297e5a7c6e8b95af8a580017/test/extended/fixtures/test-auth-build.yaml



## Additional notes

Allow use of Insecure Docker registry.
```shell
cat << EOF | sudo tee /etc/docker/daemon.json 
 {
     "insecure-registries" : [ "172.30.0.0/16" ]
 }
EOF
```