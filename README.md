# EKS Cluster

:warning:   **This repository is currently under development and may change at anytime**

An opinionated setup for eks clusters deployed with Terraform and Helm.  The AWS infrastructure is entirely setup through Terraform.  Although I prefer to use ArgoCD for Kubernetes deployments, there are a couple of services that I have included in this deployment that I think make sense when using EKS and should be available to other services right away.  These include:

- Load Balancer Controller
- EBS CSI Driver
- Cert Manager
- External DNS
- Sops Secret Operator
- ArgoCD (Development Cluster only)

With this cluster setup, services will be able to:

- Deploy behind an Application Load Balancer
- Route through a Route53 managed domain name
- Retrieve EBS storage for Stateful Sets
- Communicate over https to services within the cluster and to users outside of the cluster
- Decrypt secrets that are encrypted inside of Git using KMS
- Deploy services using a GitOps strategy to any Kubernetes cluster

# TODO

This is a list of known things that need to be worked on to make this a better general use deployment

- [ ] Rework Security Groups for worker nodes
- [ ] Formulate a scaling plan for worker nodes
- [ ] Remove opinionated helm chart deployments
- [ ] Update Jenkins job for pullImageSecret to Kubernetes Job