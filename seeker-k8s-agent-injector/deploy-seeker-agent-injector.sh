#!/bin/sh

kubectl apply -f ./deploy/namespace.yaml
kubectl apply -f ./deploy/certs.yaml
kubectl apply -f ./deploy/webhook.yaml
kubectl apply -f ./deploy/registration.yaml