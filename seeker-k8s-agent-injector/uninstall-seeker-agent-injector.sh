#!/bin/sh

kubectl delete -f ./deploy/registration.yaml
kubectl delete -f ./deploy/webhook.yaml
kubectl delete -f ./deploy/certs.yaml
kubectl delete -f ./deploy/namespace.yaml
