# hub-network

This repository has one Terraform root at its top level. Modules are organized by infrastructure responsibility:

- `modules/vpc`: hub VPC, public/private subnets, internet gateway, per-AZ NAT gateways, route tables, and subnet associations.
- `modules/transit-gateway`: hub TGW, hub VPC attachment, dedicated TGW route table, and spoke route/association after the spoke attachment exists.
- `modules/ram-share`: shares the TGW with the spoke AWS account using AWS RAM.
- `modules/vpc-tgw-routes`: routes hub private subnet traffic to the spoke through the TGW.

## Deployment

1. Copy `terraform.tfvars.example` to `terraform.tfvars`, set the spoke account ID, and review CIDRs, AZs, and tags.
2. Configure the S3 backend and state locking before using remote state. Backend configuration is intentionally not hard-coded yet.
3. Run `terraform init`, `terraform plan`, and `terraform apply` from this directory. This creates the hub VPC, TGW, hub attachment, and RAM share.
4. Provide `transit_gateway_id` and `ram_resource_share_arn` from `terraform output` to the spoke root.
5. After the spoke applies and returns `spoke_transit_gateway_attachment_id`, set `spoke_attachment_id` in this root and apply again. This associates the spoke attachment with the hub TGW route table and adds the spoke CIDR route.

The hub creates one NAT Gateway for each private subnet, which has ongoing AWS charges. Keep `allow_external_ram_principals` false for accounts in the same AWS Organization; enable it only when sharing across Organizations requires it.

If resources were already applied from the old phase roots, migrate or import their Terraform state before applying this consolidated root to avoid duplicate resource creation. 