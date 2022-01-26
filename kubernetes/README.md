# Qwik GKE Cluster Creation

- create gke cluster
```console
gcloud container clusters create <cluster_name>
```

- get auth credentials for cluster
```console
gcloud container clusters get-credential <cluster_name>
```

- deploy app to cluster
```console
kubectl create deployment hello-server \
    --image=gcr.io/google-samples/hello-app:1.0
```

- expose app to external traffic
```console
kubectl expose deployment hello-server \
    --type=LoadBalancer \
    --port 8080
```

- inspect services
```console
kubectl get service
```

- deleting a cluster
```console
gcloud container clusters delete <cluster_name>
```