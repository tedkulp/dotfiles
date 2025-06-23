# Function to get all namespaced resources in a Kubernetes namespace
function kubectlgetallresources
    for i in (kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq)
        echo "Resource: $i"
        kubectl -n $argv[1] get --ignore-not-found $i
    end
end

# Function to get all rolebindings and clusterrolebindings
function kubectlgetallbindings
    kubectl get rolebindings,clusterrolebindings --all-namespaces -o custom-columns='KIND:kind,NAMESPACE:metadata.namespace,NAME:metadata.name,SERVICE_ACCOUNTS:subjects[?(@.kind=="ServiceAccount")].name'
end

set -q KREW_ROOT; and set -gx PATH $PATH $KREW_ROOT/.krew/bin; or set -gx PATH $PATH $HOME/.krew/bin

alias k="kubectl"
