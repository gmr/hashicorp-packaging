.PHONY: download
download: downloads \
	downloads/consul \
	downloads/consul-esm \
	downloads/consul-replicate \
	downloads/consul-template \
	downloads/envconsul \
	downloads/nomad \
	downloads/packer \
	downloads/terraform \
	downloads/vault

downloads:
	@( mkdir -p downloads )

downloads/consul:
	@( echo "Downloading consul ${CONSUL_VERSION}" )
	@( curl -s -o /tmp/consul_${CONSUL_VERSION}_linux_${ARCH}.zip -L https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_${ARCH}.zip )
	@( unzip -q -d downloads/ /tmp/consul_${CONSUL_VERSION}_linux_${ARCH}.zip )
	@( rm /tmp/consul_${CONSUL_VERSION}_linux_${ARCH}.zip )

downloads/consul-esm:
	@( echo "Downloading consul-esm ${CONSUL_ESM_VERSION}" )
	@( curl -s https://releases.hashicorp.com/consul-esm/${CONSUL_ESM_VERSION}/consul-esm_${CONSUL_ESM_VERSION}_linux_${ARCH}.tgz | tar xz -C downloads/ )

downloads/consul-replicate:
	@( echo "Downloading consul-replicate ${CONSUL_REPLICATE_VERSION}" )
	@( curl -s https://releases.hashicorp.com/consul-replicate/${CONSUL_REPLICATE_VERSION}/consul-replicate_${CONSUL_REPLICATE_VERSION}_linux_${ARCH}.tgz | tar xz -C downloads/ )

downloads/consul-template:
	@( echo "Downloading consul-template ${CONSUL_TEMPLATE_VERSION}" )
	@( curl -s https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_${ARCH}.tgz | tar xz -C downloads/ )

downloads/envconsul:
	@( echo "Downloading envconsul ${ENVCONSUL_VERSION}" )
	@( curl -s https://releases.hashicorp.com/envconsul/${ENVCONSUL_VERSION}/envconsul_${ENVCONSUL_VERSION}_linux_${ARCH}.tgz | tar xz -C downloads/ )

downloads/nomad:
	@( echo "Downloading nomad ${NOMAD_VERSION}" )
	@( curl -s -o /tmp/nomad_${NOMAD_VERSION}_linux_${ARCH}.zip -L https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_${ARCH}.zip )
	@( unzip -q -d downloads/ /tmp/nomad_${NOMAD_VERSION}_linux_${ARCH}.zip )
	@( rm /tmp/nomad_${NOMAD_VERSION}_linux_${ARCH}.zip )

downloads/packer:
	@( echo "Downloading packer ${PACKER_VERSION}" )
	@( curl -s -o /tmp/packer_${PACKER_VERSION}_linux_${ARCH}.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_${ARCH}.zip )
	@( unzip -q -d downloads/ /tmp/packer_${PACKER_VERSION}_linux_${ARCH}.zip )
	@( rm /tmp/packer_${PACKER_VERSION}_linux_${ARCH}.zip )

downloads/terraform:
	@( echo "Downloading terraform ${TERRAFORM_VERSION}" )
	@( curl -s -o /tmp/terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip )
	@( unzip -q -d downloads/ /tmp/terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip )
	@( rm /tmp/terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip )

downloads/vault:
	@( echo "Downloading vault ${VAULT_VERSION}" )
	@( curl -s -o /tmp/vault_${VAULT_VERSION}_linux_${ARCH}.zip -L https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_${ARCH}.zip )
	@( unzip -q -d downloads/ /tmp/vault_${VAULT_VERSION}_linux_${ARCH}.zip )
	@( rm /tmp/vault_${VAULT_VERSION}_linux_${ARCH}.zip )
