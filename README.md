# flask-demo-deployment
Manifests for deploying the flask-demo app to Kubernetes. ArgoCD will sync to the argocd folder here and monitor the repo for changes.

## Create the ArgoCD App
Run the `create_argocd_app.sh` script to login with the argocd cli, create an argo project 
for the flask-demo, and have it sync to the deployment files.

## ArgoCD UI
View app changes by logging in to the UI. Get the ArgoCD server url and password:
* ARGOCD_SERVER=`kubectl get svc argocd-server -n argocd -o json | jq --raw-output .status.loadBalancer.ingress[0].hostname`
* ARGO_PWD=`kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2`

Go to the URL of $ARGOCD_SERVER and login as user: `admin` with password: `$ARGO_PWD`