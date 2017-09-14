.PHONY: debs
debs: download dist/debs \
    	dist/debs/consul_${CONSUL_VERSION}-${CONSUL_ITERATION}_${ARCH}.deb \
      dist/debs/consul-replicate_${REPLICATE_VERSION}-${REPLICATE_ITERATION}_${ARCH}.deb \
      dist/debs/consul-template_${TEMPLATE_VERSION}-${TEMPLATE_ITERATION}_${ARCH}.deb \
      dist/debs/envconsul_${ENVCONSUL_VERSION}-${ENVCONSUL_ITERATION}_${ARCH}.deb \
      dist/debs/hashi-ui_${HASHIUI_VERSION}-${HASHIUI_ITERATION}_${ARCH}.deb \
      dist/debs/nomad_${NOMAD_VERSION}-${NOMAD_ITERATION}_${ARCH}.deb \
      dist/debs/packer_${PACKER_VERSION}-${PACKER_ITERATION}_${ARCH}.deb \
      dist/debs/terraform_${TERRAFORM_VERSION}-${TERRAFORM_ITERATION}_${ARCH}.deb \
      dist/debs/vault_${VAULT_VERSION}-${VAULT_ITERATION}_${ARCH}.deb

dist/debs:
	@( mkdir -p dist/debs )

dist/debs/consul_${CONSUL_VERSION}-${CONSUL_ITERATION}_${ARCH}.deb:
	@( echo "Building consul ${CONSUL_VERSION} package" )
	@( mkdir -p build/deb/consul/usr/sbin )
	@( cp -R templates/deb/consul/* build/deb/consul/ )
	@( cp downloads/consul build/deb/consul/usr/sbin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/deb/consul \
				--package dist/debs/consul_${CONSUL_VERSION}-${CONSUL_ITERATION}_${ARCH}.deb \
				--name consul --version ${CONSUL_VERSION} --iteration ${CONSUL_ITERATION} \
				--deb-changelog changes/deb/consul \
				--category utils \
				--license "MPL 2.0" \
				--vendor HashiCorp \
				--deb-no-default-config-files \
				--config-files etc/consul.d/00-consul.json \
				--deb-default build/deb/consul/etc/default/consul \
				--deb-upstart upstart/consul \
				--provides consul \
				--url https://consul.io \
				--description "Consul is a tool for service discovery, monitoring and configuration" . )

dist/debs/consul-replicate_${REPLICATE_VERSION}-${REPLICATE_ITERATION}_${ARCH}.deb:
	@( echo "Building consul-replicate ${REPLICATE_VERSION} package" )
	@( mkdir -p build/deb/consul-replicate/usr/sbin )
	@( cp -R templates/deb/consul-replicate/* build/deb/consul-replicate/ )
	@( cp downloads/consul-replicate build/deb/consul-replicate/usr/sbin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/deb/consul-replicate \
				--package dist/debs/consul-replicate_${REPLICATE_VERSION}-${REPLICATE_ITERATION}_${ARCH}.deb \
				--name consul-replicate --version ${REPLICATE_VERSION} --iteration ${REPLICATE_ITERATION} \
				--deb-no-default-config-files \
				--depends consul \
				--category utils \
				--license "MPL 2.0" \
				--vendor HashiCorp \
				--deb-changelog changes/deb/consul-replicate \
				--deb-default build/deb/consul-replicate/etc/default/consul-replicate \
				--deb-upstart upstart/consul-replicate \
				--provides consul-replicate \
				--url https://github.com/hashicorp/consul-replicate \
				--description "Consul cross-DC KV replication daemon" . )

dist/debs/consul-template_${TEMPLATE_VERSION}-${TEMPLATE_ITERATION}_${ARCH}.deb:
	@( echo "Building consul-template ${TEMPLATE_VERSION} package" )
	@( mkdir -p build/deb/consul-template/usr/sbin )
	@( cp -R templates/deb/consul-template/* build/deb/consul-template/ )
	@( cp downloads/consul-template build/deb/consul-template/usr/sbin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/deb/consul-template \
				--name consul-template --version ${TEMPLATE_VERSION} --iteration ${TEMPLATE_ITERATION} \
				--package dist/debs/consul-template_${TEMPLATE_VERSION}-${TEMPLATE_ITERATION}_${ARCH}.deb \
				--depends consul \
				--category utils \
				--license "MPL 2.0" \
				--vendor HashiCorp \
				--deb-no-default-config-files \
				--deb-changelog changes/deb/consul-template \
				--config-files etc/consul-template.d/00-default.hcl \
				--deb-default build/deb/consul-template/etc/default/consul-template \
				--deb-upstart upstart/consul-template \
				--provides consul-template \
				--url https://github.com/hashicorp/consul-template \
				--description "Generic template rendering and notifications with Consul" . )

dist/debs/envconsul_${ENVCONSUL_VERSION}-${ENVCONSUL_ITERATION}_${ARCH}.deb:
	@( echo "Building envconsul ${ENVCONSUL_VERSION} package" )
	@( mkdir -p build/deb/envconsul/usr/sbin )
	@( cp -R templates/deb/envconsul/* build/deb/envconsul/ )
	@( cp downloads/envconsul build/deb/envconsul/usr/sbin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/deb/envconsul \
				--package dist/debs/envconsul_${ENVCONSUL_VERSION}-${ENVCONSUL_ITERATION}_${ARCH}.deb \
				--name envconsul --version ${ENVCONSUL_VERSION} --iteration ${ENVCONSUL_ITERATION} \
				--deb-changelog changes/deb/envconsul \
				--deb-no-default-config-files \
				--depends consul \
				--category utils \
				--license "MPL 2.0" \
				--vendor HashiCorp \
				--config-files etc/envconsul.d/00-default.hcl \
				--deb-default build/deb/envconsul/etc/default/envconsul \
				--deb-upstart upstart/envconsul \
				--provides envconsul \
				--url https://github.com/hashicorp/envconsul \
				--description "Read and set environmental variables for processes from Consul" . )

dist/debs/hashi-ui_${HASHIUI_VERSION}-${HASHIUI_ITERATION}_${ARCH}.deb:
	@( echo "Building hashi-ui ${HASHIUI_VERSION} package" )
	@( mkdir -p build/deb/hashi-ui/usr/sbin )
	@( cp -R templates/deb/hashi-ui/* build/deb/hashi-ui/ )
	@( cp downloads/hashi-ui build/deb/hashi-ui/usr/sbin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/deb/hashi-ui \
				--deb-no-default-config-files \
				--package dist/debs/hashi-ui_${HASHIUI_VERSION}-${HASHIUI_ITERATION}_${ARCH}.deb \
				--name hashi-ui --version ${HASHIUI_VERSION} --iteration ${HASHIUI_ITERATION} \
				--deb-changelog changes/deb/hashi-ui \
				--category utils \
				--license MIT \
				--deb-default build/deb/hashi-ui/etc/default/hashi-ui \
				--deb-upstart upstart/hashi-ui \
				--provides hashi-ui \
				--url https://github.com/jippi/hashi-ui \
				--description "A modern user interface for @hashicorp Consul & Nomad" . )

dist/debs/nomad_${NOMAD_VERSION}-${NOMAD_ITERATION}_${ARCH}.deb:
	@( echo "Building nomad ${NOMAD_VERSION} package" )
	@( mkdir -p build/deb/nomad/usr/sbin )
	@( cp -R templates/deb/nomad/* build/deb/nomad/ )
	@( cp downloads/nomad build/deb/nomad/usr/sbin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/deb/nomad \
				--package dist/debs/nomad_${NOMAD_VERSION}-${NOMAD_ITERATION}_${ARCH}.deb \
				--name nomad --version ${NOMAD_VERSION} --iteration ${NOMAD_ITERATION} \
				--deb-changelog changes/deb/nomad \
				--deb-no-default-config-files \
				--depends consul \
				--category utils \
				--license "MPL 2.0" \
				--vendor HashiCorp \
  			--config-files etc/nomad.d/00-default.hcl \
				--deb-default build/deb/nomad/etc/default/nomad \
				--deb-upstart upstart/nomad \
				--provides nomad \
				--url https://www.nomadproject.io \
				--description "Easily Deploy Applications at Any Scale" . )

dist/debs/packer_${PACKER_VERSION}-${PACKER_ITERATION}_${ARCH}.deb:
	@( echo "Building packer ${PACKER_VERSION} package" )
	@( mkdir -p build/deb/packer/usr/bin )
	@( cp downloads/packer build/deb/packer/usr/bin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/deb/packer \
				--package dist/debs/packer_${PACKER_VERSION}-${PACKER_ITERATION}_${ARCH}.deb \
				--name packer --version ${PACKER_VERSION} --iteration ${PACKER_ITERATION} \
				--deb-changelog changes/deb/packer \
				--deb-no-default-config-files \
				--no-depends \
				--category utils \
				--license "MPL 2.0" \
				--vendor HashiCorp \
				--provides packer \
				--url https://www.packer.io \
				--description "A tool for creating identical machine images for multiple platforms from a single source configuration." . )

dist/debs/terraform_${TERRAFORM_VERSION}-${TERRAFORM_ITERATION}_${ARCH}.deb:
	@( echo "Building terraform ${TERRAFORM_VERSION} package" )
	@( mkdir -p build/deb/terraform/usr/bin )
	@( cp downloads/terraform build/deb/terraform/usr/bin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/deb/terraform \
				--package dist/debs/terraform_${TERRAFORM_VERSION}-${TERRAFORM_ITERATION}_${ARCH}.deb \
				--name terraform --version ${TERRAFORM_VERSION} --iteration ${TERRAFORM_ITERATION} \
				--deb-changelog changes/deb/terraform \
				--deb-no-default-config-files \
				--no-depends \
				--category utils \
				--license "MPL 2.0" \
				--vendor HashiCorp \
				--provides terraform \
				--url https://www.terraform.io \
				--description "A tool for building, changing, and combining infrastructure safely and efficiently." . )

dist/debs/vault_${VAULT_VERSION}-${VAULT_ITERATION}_${ARCH}.deb:
	@( echo "Building vault ${VAULT_VERSION} package" )
	@( mkdir -p build/deb/vault/usr/sbin )
	@( cp -R templates/deb/vault/* build/deb/vault/ )
	@( cp downloads/vault build/deb/vault/usr/sbin/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
				-C build/deb/vault \
				--package dist/debs/vault_${VAULT_VERSION}-${VAULT_ITERATION}_${ARCH}.deb \
				--name vault --version ${VAULT_VERSION} --iteration ${VAULT_ITERATION} \
				--deb-changelog changes/deb/vault \
				--deb-no-default-config-files \
				--depends consul \
				--category utils \
				--license "MPL 2.0" \
				--vendor HashiCorp \
				--config-files etc/vault.hcl \
				--deb-default build/deb/vault/etc/default/vault \
				--deb-upstart upstart/vault \
				--provides vault \
				--url https://vaultproject.io \
				--description "A tool for managing secrets" . )

.PHONEY: deb-contents
deb-contents: debs
	dpkg --contents dist/debs/consul_${CONSUL_VERSION}-${CONSUL_ITERATION}_${ARCH}.deb
	dpkg --contents dist/debs/consul-replicate_${REPLICATE_VERSION}-${REPLICATE_ITERATION}_${ARCH}.deb
	dpkg --contents dist/debs/consul-template_${TEMPLATE_VERSION}-${TEMPLATE_ITERATION}_${ARCH}.deb
	dpkg --contents dist/debs/envconsul_${ENVCONSUL_VERSION}-${ENVCONSUL_ITERATION}_${ARCH}.deb
	dpkg --contents dist/debs/hashi-ui_${HASHIUI_VERSION}-${HASHIUI_ITERATION}_${ARCH}.deb
	dpkg --contents dist/debs/nomad_${NOMAD_VERSION}-${NOMAD_ITERATION}_${ARCH}.deb
	dpkg --contents dist/debs/packer_${PACKER_VERSION}-${PACKER_ITERATION}_${ARCH}.deb
	dpkg --contents dist/debs/terraform_${TERRAFORM_VERSION}-${TERRAFORM_ITERATION}_${ARCH}.deb
	dpkg --contents dist/debs/vault_${VAULT_VERSION}-${VAULT_ITERATION}_${ARCH}.deb

.PHONEY: deb-info
deb-info: debs
	dpkg --info dist/debs/consul_${CONSUL_VERSION}-${CONSUL_ITERATION}_${ARCH}.deb
	dpkg --info dist/debs/consul-replicate_${REPLICATE_VERSION}-${REPLICATE_ITERATION}_${ARCH}.deb
	dpkg --info dist/debs/consul-template_${TEMPLATE_VERSION}-${TEMPLATE_ITERATION}_${ARCH}.deb
	dpkg --info dist/debs/envconsul_${ENVCONSUL_VERSION}-${ENVCONSUL_ITERATION}_${ARCH}.deb
	dpkg --info dist/debs/hashi-ui_${HASHIUI_VERSION}-${HASHIUI_ITERATION}_${ARCH}.deb
	dpkg --info dist/debs/nomad_${NOMAD_VERSION}-${NOMAD_ITERATION}_${ARCH}.deb
	dpkg --info dist/debs/packer_${PACKER_VERSION}-${PACKER_ITERATION}_${ARCH}.deb
	dpkg --info dist/debs/terraform_${TERRAFORM_VERSION}-${TERRAFORM_ITERATION}_${ARCH}.deb
	dpkg --info dist/debs/vault_${VAULT_VERSION}-${VAULT_ITERATION}_${ARCH}.deb
