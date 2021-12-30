create a project using docker 4, and using a docker image using the azure container registry

it takes a while to provision a cluster, so it is not best to deploy one during a demo, 

but once deployed it is easier to walk back the steps for posterity

# the link to the tutorial is here:
`https://docs.microsoft.com/en-us/azure/openshift/tutorial-create-cluster`

clusters are called resource groups, and it generates a resource group in OCP to provision 
the resources 

# command to show url.. it seems?
az aro show -g aro -n cluster --query apiserverProfile.url -o tsv

command to log into OCP
oc login [url :portNumber?] -u [username] -p [password]

# uername - kubeadmin -p VZMVf-gckkk-qpD3g-RwH5T

oc use project [project]

oc new app [name]

oc get svc

oc expose [project]

# ilnk for microsoft azure pricing 
https://azure.microsoft.com/en-us/pricing/details/openshift/

# more info on monitoring in OCP with azure
https://azure.microsoft.com/en-us/pricing/details/openshift/