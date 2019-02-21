# Kubernetes Hello World Node.js

This project is intended to be used as a sample for 
deployment of kubernetes applications. 

Basically this expose 3 apis:
- /ping
- /current-date
- /fibo/:n

The last one is good to test the capacity of the cluster by implement 
a fibonnaci with any number specified. Numbers great than 35 could crash your server :)

# Start

Build the image

```
docker build byjg/k8s-hello-node
```

Run the Image

```
docker run -d -p 3000:3000 byjg/k8s-hello-node
```

# Deploying in the Kubernetes cluster

First create the Pods and the autoscale 

```
kubectl apply -f kubernetes/deployment.yml
```

Check if is OK:

```
kubectl get pods -l app=k8s-node -o yaml | grep podIP
```

# Exposing the Api to the World:

```
kubectl apply -f kubernetes/service-external.yml
```

Checking:

```
kubectl get service
```

Run this to see the auto scaling working:

```
ab -n 500 -c 10 -s 600 http://<IP>/fibo/35
```

# Exposing the Api inside the cluster:


```
kubectl apply -f kubernetes/service-external.yml
```

Checking:

```
kubectl run terminal --generator=run-pod/v1 --image=alpine:3.8 -i --tty
```