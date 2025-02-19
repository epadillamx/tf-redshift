## Installation

Deploy AWS

```bash
  terraform fmt -recursive
  terraform init
  terraform plan
  terraform apply -auto-approve
  terraform output
  terraform destroy -auto-approve
```

```bash
  terraform destroy -target=module.<nombre_del_módulo>
```