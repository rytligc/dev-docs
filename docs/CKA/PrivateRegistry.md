# Pull from a private registry and pull secret

Logging in needs to happen via secrets.

## Exam / imperative method

```bash
kubectl create secret docker-registry regcred \
 --docker-server=<your-registry-server> \
 --docker-username=<your-name> \
 --docker-password=<your-pword> \
 --docker-email=<your-email>
```

## Creating a pod that uses the secret and private registry

```yml
apiVersion: v1
kind: Pod
metadata:
  name: private-reg
spec:
  containers:
  - name: private-reg-container
    # Private registry
    image: my-private-registry.io/tooling/awesome-tool:latest
  # Pull secret from above
  imagePullSecrets:
  - name: regcred
```

## Docker way

```bash
# The login process creates or updates a config.json file that holds an authorization token.
docker login
```

```bash
# View the token
cat ~/.docker/config.json
```

```json
{
    "auths": {
        "https://index.docker.io/v1/": {
            "auth": "c3R...zE2"
        }
    }
}
```

```bash
# Create secret based on 'docker login' config.json
kubectl create secret generic regcred \
    --from-file=.dockerconfigjson=<path/to/.docker/config.json> \
    --type=kubernetes.io/dockerconfigjson
```

Alternatively to using the imperative way, a yaml file can also be created which  
can help if more things need to be added such as a namespace:

```yml
apiVersion: v1
kind: Secret
metadata:
  name: myregistrykey
  namespace: awesomeapps
data:
  .dockerconfigjson: UmVhbGx5IHJlYWxseSByZWVlZWVlZWV... # This is the dockerconfigjson base64 encoded
type: kubernetes.io/dockerconfigjson
```

### Inspect the output

```bash
# yaml
kubectl get secret regcred --output=yaml

# dockerconfigjson
kubectl get secret regcred --output="jsonpath={.data.\.dockerconfigjson}" | base64 --decode
echo "c3R...zE2" | base64 --decode
```