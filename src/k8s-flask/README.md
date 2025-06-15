# Kubernetes deployment and PVC configuration for a Flask application using SQLite.

I have a container image on DockerHub that starts a Flask app with SQLite. It calculates commissions and stores them in a SQLite database. 

## Initial Setup

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

## Destroy Resources but keep the database
```bash
terraform apply -var="deployment_enabled=false" -auto-approve
```

## Recreate Resources and remout the database
```bash
terraform apply -var="deployment_enabled=true" -auto-approve
```

## Destroy Resources and PVC
```bash
terraform destroy -auto-approve
```