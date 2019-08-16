# Run workflows with [Argo](https://github.com/argoproj/argo/)

* Access [OpenShift](https://app.dsri.unimaas.nl:8443/)

* Access [Argo UI](http://argo-ui-argo.app.dsri.unimaas.nl/workflows)

## Install oc client

```shell
wget https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz

tar xvf openshift-origin-client-tools*.tar.gz
cd openshift-origin-client*/
sudo mv oc kubectl /usr/local/bin/
```

---

## oc login

Login to the cluster using the OpenShift client
```shell
oc login https://openshift_cluster:8443 --token=MY_TOKEN
```

Get the command with the token from the `Copy Login Command` button in the user details at the top right of the OpenShift webpage.

---

## Argo

Install [Argo client](https://github.com/argoproj/argo/blob/master/demo.md#1-download-argo)

Run workflows with Argo

```shell
argo submit --watch d2s-sparql-workflow.yaml

# Define params in a separate YAML file (no _ in params name)
argo submit d2s-workflow-transform-xml.yaml -f workflow-params-drugbank.yml
```

---

## oc run

### Pods

```shell
oc new-app --file=./example/myapp/template.json --param=MYSQL_USER=admin

oc create -f examples/hello-openshift/hello-pod.json

oc run nginx --image=nginx --overrides='{ "apiVersion": "v1", "spec": { ... } }'
oc run 
```


