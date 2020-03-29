set -e

# hub_user=$(az keyvault secret show --vault-name ModellingMindKeyVault --subscription MindModelSub --name dockerhub-user -o tsv | awk '{print $NF}')
# hub_pass=$(az keyvault secret show --vault-name ModellingMindKeyVault --subscription MindModelSub --name dockerhub-token -o tsv | awk '{print $NF}')
hub_user=$1
hub_pass=$2
image=$3
tag=$4

azure_registry="xmind.azurecr.io"
dockerhub_org="xmindai"

get="docker pull ${azure_registry}/${image}:${tag}"
login="echo ${hub_pass} | docker login -u ${hub_user} --password-stdin"
dtag="docker tag ${azure_registry}/${image}:${tag} ${dockerhub_org}/${image}:${tag}"
push="docker push ${dockerhub_org}/${image}:${tag}"

az acr run --cmd "${get} && ${login} && ${dtag} && ${push}" --no-wait --registry xmind /dev/null