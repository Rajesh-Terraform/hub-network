# Phase 5 - Hub EC2

This independent Terraform root creates one private Amazon Linux EC2 instance
in the deployed hub VPC, with an instance profile for Systems Manager Session
Manager. It does not create or change VPC routes, Transit Gateway routes,
attachments, or the spoke network.

Run **Phase 5 - Hub EC2** manually from the Actions tab on `main`. Select
`apply` or `destroy` and provide the existing hub VPC ID and a private subnet
ID. The workflow assumes the hub role
`arn:aws:iam::647132523867:role/github-actions-test-role`. That role needs
permissions to manage the EC2, security group, IAM role/profile, and this root's
Terraform state and lock file.

The instance type is fixed to `t3.micro`. This is a small, commonly free-tier
eligible type, but AWS billing eligibility depends on the account, offer, and
usage. The instance has no public IP. The hub's private subnet needs its
existing NAT route for SSM connectivity.

Use the separate spoke workflow to create its instance. When finished, destroy
each instance using its own workflow.
