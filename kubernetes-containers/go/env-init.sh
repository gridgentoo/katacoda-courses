#!/bin/sh

launch.sh

# Common curl switches
echo '-s' > ~/.curlrc

# Allow pygmentize for source highlighting
docker pull whalebrew/pygmentize
echo 'function ccat() { docker run -it -v "$(pwd)":/workdir -w /workdir     whalebrew/pygmentize $1; }' >> ~/.bashrc
source ~/.bashrc

# Helm setup
HELM_VERSION=v3.1.2
    curl -fsSL https://get.helm.sh/helm-$HELM_VERSION-linux-amd64.tar.gz | tar -zxvf - -C /usr/local/bin/ linux-amd64/helm --strip=1
helm repo add stable https://kubernetes-charts.storage.googleapis.com/

# Setup dashboard on port 30000
helm install dash stable/kubernetes-dashboard \
--namespace kube-system \
--set=service.type=NodePort \
--set=enableInsecureLogin=true \
--set=service.nodePort=30000 \
--set=service.externalPort=80

source <(kubectl completion bash)
source <(helm completion bash)

apt update > /dev/null 2>&1
apt install tree --yes -qq

{ clear && echo 'Kubernetes with Helm is ready.'; } 2> /dev/null
