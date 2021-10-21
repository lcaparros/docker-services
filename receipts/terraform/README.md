# Terraform

This section includes the necessary code and files to create all the necessary infrastructure in some of the most common cloud providers.

## Usage

First at all it is necessary to initiate terraform. Then you can veerify you _.tf_ files and finally you will be able to apply your changes.

```shell
terraform init
terraform plan
terraform apply
```

> :info: Terraform will recognize all the environment variables with the nomenclature `TF_VAR_name` as the `name` variable