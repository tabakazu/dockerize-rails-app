# Usage

Initialize terraform configuration files
```bash
$ terraform init
```

Provisioning aws resources
```bash
$ terraform plan
$ terraform apply
```

Push along ecr page in aws management console
```bash
# login
$ bash -c '$(aws ecr get-login --no-include-email --region ap-northeast-1)'
```
- dockerize-webapp-demo/containers/web/Dockerfile
- dockerize-webapp-demo/containers/webapp/Dockerfile