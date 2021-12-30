deploy building from a [emergency].build.properties which makes a config file in OCP, which then kicks off a registry entry when jenkins kicks off the build config it makes an image in the nonprod registry

then I have to tag and promote the image, the right proj, branch, latest srcTag, and target has to be prd. 

for the train thing, change the image tag in the OCP reuntime  (that has to be changed in the jenkins job for deployment)

argo tekton pipeline will keep this from being an issue in the future.