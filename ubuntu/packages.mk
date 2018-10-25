.PHONY: ubuntu ubunu/consul

CONSUL_ITERATION=1
CONSUL_ESM_ITERATION=1
CONSUL_REPLICATE_ITERATION=2
CONSUL_TEMPLATE_ITERATION=1
ENVCONSUL_ITERATION=1
NOMAD_ITERATION=1
PACKER_ITERATION=1
TERRAFORM_ITERATION=1
VAULT_ITERATION=1

-include ubuntu/consul.mk
-include ubuntu/consul-esm.mk
-include ubuntu/consul-replicate.mk
-include ubuntu/consul-template.mk
-include ubuntu/envconsul.mk
-include ubuntu/nomad.mk
-include ubuntu/packer.mk
-include ubuntu/terraform.mk
-include ubuntu/vault.mk

ubuntu: download dist/ubuntu \
    	dist/ubuntu/consul_${CONSUL_VERSION}-${CONSUL_ITERATION}_${ARCH}.deb \
    	dist/ubuntu/consul-esm_${CONSUL_ESM_VERSION}-${CONSUL_ESM_ITERATION}_${ARCH}.deb \
      dist/ubuntu/consul-replicate_${CONSUL_REPLICATE_VERSION}-${CONSUL_REPLICATE_ITERATION}_${ARCH}.deb \
      dist/ubuntu/consul-template_${CONSUL_TEMPLATE_VERSION}-${CONSUL_TEMPLATE_ITERATION}_${ARCH}.deb \
      dist/ubuntu/envconsul_${ENVCONSUL_VERSION}-${ENVCONSUL_ITERATION}_${ARCH}.deb \
      dist/ubuntu/nomad_${NOMAD_VERSION}-${NOMAD_ITERATION}_${ARCH}.deb \
      dist/ubuntu/packer_${PACKER_VERSION}-${PACKER_ITERATION}_${ARCH}.deb \
      dist/ubuntu/terraform_${TERRAFORM_VERSION}-${TERRAFORM_ITERATION}_${ARCH}.deb \
      dist/ubuntu/vault_${VAULT_VERSION}-${VAULT_ITERATION}_${ARCH}.deb

ubuntu/consul: download dist/ubuntu dist/ubuntu/consul_${CONSUL_VERSION}-${CONSUL_ITERATION}_${ARCH}.deb

dist/ubuntu:
	@( mkdir -p dist/ubuntu )

.PHONEY: deb-contents
deb-contents: ubuntu
	dpkg --contents dist/ubuntu/consul_${CONSUL_VERSION}-${CONSUL_ITERATION}_${ARCH}.deb
	dpkg --contents dist/ubuntu/consul-esm_${CONSUL_ESM_VERSION}-${CONSUL_ESM_ITERATION}_${ARCH}.deb
	dpkg --contents dist/ubuntu/consul-replicate_${CONSUL_REPLICATE_VERSION}-${CONSUL_REPLICATE_ITERATION}_${ARCH}.deb
	dpkg --contents dist/ubuntu/consul-template_${CONSUL_TEMPLATE_VERSION}-${CONSUL_TEMPLATE_ITERATION}_${ARCH}.deb
	dpkg --contents dist/ubuntu/envconsul_${ENVCONSUL_VERSION}-${ENVCONSUL_ITERATION}_${ARCH}.deb
	dpkg --contents dist/ubuntu/nomad_${NOMAD_VERSION}-${NOMAD_ITERATION}_${ARCH}.deb
	dpkg --contents dist/ubuntu/packer_${PACKER_VERSION}-${PACKER_ITERATION}_${ARCH}.deb
	dpkg --contents dist/ubuntu/terraform_${TERRAFORM_VERSION}-${TERRAFORM_ITERATION}_${ARCH}.deb
	dpkg --contents dist/ubuntu/vault_${VAULT_VERSION}-${VAULT_ITERATION}_${ARCH}.deb

.PHONEY: deb-info
deb-info: ubuntu
	dpkg --info dist/ubuntu/consul_${CONSUL_VERSION}-${CONSUL_ITERATION}_${ARCH}.deb
	dpkg --info dist/ubuntu/consul-esm_${CONSUL_ESM_VERSION}-${CONSUL_ESM_ITERATION}_${ARCH}.deb
	dpkg --info dist/ubuntu/consul-replicate_${CONSUL_REPLICATE_VERSION}-${CONSUL_REPLICATE_ITERATION}_${ARCH}.deb
	dpkg --info dist/ubuntu/consul-template_${CONSUL_TEMPLATE_VERSION}-${CONSUL_TEMPLATE_ITERATION}_${ARCH}.deb
	dpkg --info dist/ubuntu/envconsul_${ENVCONSUL_VERSION}-${ENVCONSUL_ITERATION}_${ARCH}.deb
	dpkg --info dist/ubuntu/nomad_${NOMAD_VERSION}-${NOMAD_ITERATION}_${ARCH}.deb
	dpkg --info dist/ubuntu/packer_${PACKER_VERSION}-${PACKER_ITERATION}_${ARCH}.deb
	dpkg --info dist/ubuntu/terraform_${TERRAFORM_VERSION}-${TERRAFORM_ITERATION}_${ARCH}.deb
	dpkg --info dist/ubuntu/vault_${VAULT_VERSION}-${VAULT_ITERATION}_${ARCH}.deb
