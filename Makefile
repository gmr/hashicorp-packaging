CONSUL_VERSION=1.3.0
CONSUL_ESM_VERSION=0.3.0
CONSUL_REPLICATE_VERSION=0.4.0
CONSUL_TEMPLATE_VERSION=0.19.5
ENVCONSUL_VERSION=0.7.3
NOMAD_VERSION=0.8.6
PACKER_VERSION=1.3.1
TERRAFORM_VERSION=0.11.10
VAULT_VERSION=0.11.4

PACKAGER="Gavin M. Roy <gavinr@aweber.com>"
ARCH=amd64

clean:
	@( rm -rf build/* )
	@( rm -rf dist/* )
	@( rm -rf downloads/* )

-include download.mk
-include ubuntu/packages.mk
