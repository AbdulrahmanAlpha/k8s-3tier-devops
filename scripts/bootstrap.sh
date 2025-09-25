#!/usr/bin/env bash
set -e
cd terraform
echo "Copy terraform.tfvars.example -> terraform.tfvars and edit values (aws_account_id, jenkins_key_name, db_password)"
cp terraform.tfvars.example terraform.tfvars || true
echo "Run: terraform init && terraform plan"
