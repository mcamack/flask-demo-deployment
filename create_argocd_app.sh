# Setup argocd cli to interact with our EKS cluster
ARGOCD_SERVER=`kubectl get svc argocd-server -n argocd -o json | jq --raw-output .status.loadBalancer.ingress[0].hostname`
ARGO_PWD=`kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2`
argocd login $ARGOCD_SERVER --username admin --password $ARGO_PWD --insecure

# Create the flask-demo app in ArgoCD
argocd app create flask-demo --repo https://github.com/mcamack/flask-demo-deployment.git --path argocd --dest-server https://kubernetes.default.svc --dest-namespace flask-demo

# Sync the app
argocd app sync flask-demo