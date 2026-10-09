# hub-network

This repository has one Terraform root at its top level. Modules are organized by infrastructure responsibility:

- `modules/vpc`: hub VPC, public/private subnets, internet gateway, per-AZ NAT gateways, route tables, and subnet associations.
- `modules/transit-gateway`: hub TGW, hub VPC attachment, dedicated TGW route table, and spoke route/association after the spoke attachment exists.
- `modules/ram-share`: shares the TGW with the spoke AWS account using AWS RAM.
- `modules/vpc-tgw-routes`: routes hub private subnet traffic to the spoke through the TGW.

## Deployment

1. Copy `terraform.tfvars.example` to `terraform.tfvars`, set the spoke account ID, and review CIDRs, AZs, and tags.
2. The Terraform state is stored in the `hubstatefile/terraform.tfstate` key in the `dhoni-demo-terraform-bucket-123456` S3 bucket in `ap-south-1`. The bucket must exist, have versioning enabled, and allow the GitHub Actions role to list the bucket and read/write the state and `.tflock` objects.
3. Run `terraform init` and `terraform plan` from this directory.
4. If AWS resources were created by an earlier run without remote state, import those resources into this backend before applying. A fresh remote state does not know about resources created by a previous GitHub Actions runner.
5. After the state is reconciled, set the GitHub Actions repository variable `TF_APPLY_ENABLED` to `true` to allow the workflow to apply on pushes to `main`. Until then, the workflow plans but skips apply.
6. Provide `transit_gateway_id` and `ram_resource_share_arn` from `terraform output` to the spoke root.
7. After the spoke applies and returns `spoke_transit_gateway_attachment_id`, set `spoke_attachment_id` in this root and apply again. This associates the spoke attachment with the hub TGW route table and adds the spoke CIDR route.

The hub creates one NAT Gateway for each private subnet, which has ongoing AWS charges. Keep `allow_external_ram_principals` false for accounts in the same AWS Organization; enable it only when sharing across Organizations requires it.

If resources were already applied from the old phase roots, migrate or import their Terraform state before applying this consolidated root to avoid duplicate resource creation. 