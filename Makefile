CONSUL_VERSION=0.9.3
REPLICATE_VERSION=0.4.0
TEMPLATE_VERSION=0.19.3
ENVCONSUL_VERSION=0.7.2
HASHIUI_VERSION=0.18.0
NOMAD_VERSION=0.6.3
PACKER_VERSION=1.1.0
VAULT_VERSION=0.8.2

CONSUL_ITERATION=1
ENVCONSUL_ITERATION=2
HASHIUI_ITERATION=1
NOMAD_ITERATION=1
PACKER_ITERATION=1
REPLICATE_ITERATION=1
TEMPLATE_ITERATION=2
VAULT_ITERATION=2

PACKAGER="Gavin M. Roy <gavinr@aweber.com>"
ARCH=amd64

all: consul consul-replicate consul-template envconsul hashi-ui nomad packer vault

clean:
	@( rm -rf build/* )
	@( rm -rf dist/* )

consul: dist/consul_${CONSUL_VERSION}-${CONSUL_ITERATION}_${ARCH}.deb

consul-replicate: dist/consul-replicate_${REPLICATE_VERSION}-${REPLICATE_ITERATION}_${ARCH}.deb

consul-template: dist/consul-template_${TEMPLATE_VERSION}-${TEMPLATE_ITERATION}_${ARCH}.deb

envconsul: dist/envconsul_${ENVCONSUL_VERSION}-${ENVCONSUL_ITERATION}_${ARCH}.deb

hashi-ui: dist/hashi-ui_${HASHIUI_VERSION}-${HASHIUI_ITERATION}_${ARCH}.deb

nomad: dist/nomad_${NOMAD_VERSION}-${NOMAD_ITERATION}_${ARCH}.deb

packer: dist/packer_${PACKER_VERSION}-${PACKER_ITERATION}_${ARCH}.deb

vault: dist/vault_${VAULT_VERSION}-${VAULT_ITERATION}_${ARCH}.deb

dist/consul_${CONSUL_VERSION}-${CONSUL_ITERATION}_${ARCH}.deb: build/consul/usr/sbin/consul
	@( mkdir -p dist )
	@( echo "Building consul ${CONSUL_VERSION} package" )
	@( mkdir -p build/consul )
	@( cp -R templates/consul/* build/consul/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
			-C build/consul \
			--package dist/consul_${CONSUL_VERSION}-${CONSUL_ITERATION}_${ARCH}.deb \
			--name consul --version ${CONSUL_VERSION} --iteration ${CONSUL_ITERATION} \
			--deb-changelog changes/consul \
			--category utils \
		  --deb-no-default-config-files \
			--config-files etc/consul.d/00-consul.json \
			--deb-default build/consul/etc/default/consul \
			--deb-upstart build/consul/etc/init/consul.conf \
			--provides consul \
			--description "Consul is a tool for service discovery, monitoring and configuration" . )

dist/consul-replicate_${REPLICATE_VERSION}-${REPLICATE_ITERATION}_${ARCH}.deb: build/consul-replicate/usr/sbin/consul-replicate
	@( mkdir -p dist )
	@( echo "Building consul-replicate ${TEMPLATE_VERSION} package" )
	@( mkdir -p build/consul-replicate )
	@( cp -R templates/consul-replicate/* build/consul-replicate/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
			-C build/consul-replicate \
			--package dist/consul-replicate_${REPLICATE_VERSION}-${REPLICATE_ITERATION}_${ARCH}.deb \
			--name consul-replicate --version ${REPLICATE_VERSION} --iteration ${REPLICATE_ITERATION} \
		  --deb-no-default-config-files \
			--depends consul \
			--category utils \
			--deb-changelog changes/consul-replicate \
			--deb-default build/consul-replicate/etc/default/consul-replicate \
			--deb-upstart build/consul-replicate/etc/init/consul-replicate.conf \
			--provides consul-replicate \
			--description "Consul cross-DC KV replication daemon" . )

dist/consul-template_${TEMPLATE_VERSION}-${TEMPLATE_ITERATION}_${ARCH}.deb: build/consul-template/usr/sbin/consul-template
	@( mkdir -p dist )
	@( echo "Building consul-template ${TEMPLATE_VERSION} package" )
	@( mkdir -p build/consul-template )
	@( cp -R templates/consul-template/* build/consul-template/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
			-C build/consul-template \
			--name consul-template --version ${TEMPLATE_VERSION} --iteration ${TEMPLATE_ITERATION} \
			--package dist/consul-template_${TEMPLATE_VERSION}-${TEMPLATE_ITERATION}_${ARCH}.deb \
			--depends consul \
			--category utils \
		  --deb-no-default-config-files \
			--deb-changelog changes/consul-template \
			--config-files etc/consul-template.d/00-default.hcl \
			--deb-default build/consul-template/etc/default/consul-template \
			--deb-upstart build/consul-template/etc/init/consul-template.conf \
			--provides consul-template \
			--exclude /etc/conf/consul-template.conf.conf \
			--description "Generic template rendering and notifications with Consul" . )

dist/envconsul_${ENVCONSUL_VERSION}-${ENVCONSUL_ITERATION}_${ARCH}.deb: build/envconsul/usr/sbin/envconsul
	@( mkdir -p dist )
	@( echo "Building envconsul ${ENVCONSUL_VERSION} package" )
	@( mkdir -p build/envconsul )
	@( cp -R templates/envconsul/* build/envconsul/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
			-C build/envconsul \
			--package dist/envconsul_${ENVCONSUL_VERSION}-${ENVCONSUL_ITERATION}_${ARCH}.deb \
			--name envconsul --version ${ENVCONSUL_VERSION} --iteration ${ENVCONSUL_ITERATION} \
			--deb-changelog changes/envconsul \
		  --deb-no-default-config-files \
			--depends consul \
			--category utils \
			--config-files etc/envconsul.d/00-default.hcl \
			--deb-default build/envconsul/etc/default/envconsul \
			--deb-upstart build/envconsul/etc/init/envconsul.conf \
			--provides envconsul \
			--description "Read and set environmental variables for processes from Consul" . )

dist/hashi-ui_${HASHIUI_VERSION}-${HASHIUI_ITERATION}_${ARCH}.deb: build/hashi-ui/usr/sbin/hashi-ui
	@( mkdir -p dist )
	@( echo "Building hashi-ui ${HASHIUI_VERSION} package" )
	@( mkdir -p build/hashi-ui )
	@( cp -R templates/hashi-ui/* build/hashi-ui/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
			-C build/hashi-ui \
		  --deb-no-default-config-files \
			--package dist/hashi-ui_${HASHIUI_VERSION}-${HASHIUI_ITERATION}_${ARCH}.deb \
			--name hashi-ui --version ${HASHIUI_VERSION} --iteration ${HASHIUI_ITERATION} \
			--deb-changelog changes/hashi-ui \
			--category utils \
			--deb-default build/hashi-ui/etc/default/hashi-ui \
			--deb-upstart build/hashi-ui/etc/init/hashi-ui.conf \
			--provides hashi-ui \
			--description "A modern user interface for @hashicorp Consul & Nomad" . )

dist/nomad_${NOMAD_VERSION}-${NOMAD_ITERATION}_${ARCH}.deb: build/nomad/usr/sbin/nomad
	@( mkdir -p dist )
	@( echo "Building nomad ${NOMAD_VERSION} package" )
	@( mkdir -p build/nomad )
	@( cp -R templates/nomad/* build/nomad/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
			-C build/nomad \
			--package dist/nomad_${NOMAD_VERSION}-${NOMAD_ITERATION}_${ARCH}.deb \
			--name nomad --version ${NOMAD_VERSION} --iteration ${NOMAD_ITERATION} \
			--deb-changelog changes/nomad \
		  --deb-no-default-config-files \
			--depends consul \
			--category utils \
			--config-files etc/nomad.d/00-default.hcl \
			--deb-default build/nomad/etc/default/nomad \
			--deb-upstart build/nomad/etc/init/nomad.conf \
			--provides nomad \
			--description "Easily Deploy Applications at Any Scale" . )

dist/packer_${PACKER_VERSION}-${PACKER_ITERATION}_${ARCH}.deb: build/packer/usr/bin/packer
	@( mkdir -p dist )
	@( echo "Building packer ${PACKER_VERSION} package" )
	@( mkdir -p build/packer )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
			-C build/packer \
			--package dist/packer_${PACKER_VERSION}-${PACKER_ITERATION}_${ARCH}.deb \
			--name packer --version ${PACKER_VERSION} --iteration ${PACKER_ITERATION} \
			--deb-changelog changes/packer \
		  --deb-no-default-config-files \
			--category utils \
			--provides packer \
			--description "A tool for creating identical machine images for multiple platforms from a single source configuration." . )

dist/vault_${VAULT_VERSION}-${VAULT_ITERATION}_${ARCH}.deb: build/vault/usr/sbin/vault
	@( mkdir -p dist )
	@( echo "Building vault ${VAULT_VERSION} package" )
	@( mkdir -p build/vault )
	@( cp -R templates/vault/* build/vault/ )
	@( fpm -s dir -t deb -m ${PACKAGER} -a ${ARCH} \
			-C build/vault \
			--package dist/vault_${VAULT_VERSION}-${VAULT_ITERATION}_${ARCH}.deb \
			--name vault --version ${VAULT_VERSION} --iteration ${VAULT_ITERATION} \
			--deb-changelog changes/vault \
		  --deb-no-default-config-files \
			--depends consul \
			--category utils \
			--config-files etc/vault.hcl \
			--deb-default build/vault/etc/default/vault \
			--deb-upstart build/vault/etc/init/vault.conf \
			--provides vault \
			--description "A tool for managing secrets" . )

build/consul/usr/sbin/consul:
	@( echo "Downloading consul ${CONSUL_VERSION}" )
	@( mkdir -p build/consul/usr/sbin/ )
	@( curl -s -o /tmp/consul_${CONSUL_VERSION}_linux_${ARCH}.zip -L https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_${ARCH}.zip )
	@( unzip -q -d build/consul/usr/sbin/ /tmp/consul_${CONSUL_VERSION}_linux_${ARCH}.zip )
	@( rm /tmp/consul_${CONSUL_VERSION}_linux_${ARCH}.zip )

build/consul-replicate/usr/sbin/consul-replicate:
	@( echo "Downloading consul-replicate ${REPLICATE_VERSION}" )
	@( mkdir -p build/consul-replicate/usr/sbin )
	@( curl -s https://releases.hashicorp.com/consul-replicate/${REPLICATE_VERSION}/consul-replicate_${REPLICATE_VERSION}_linux_${ARCH}.tgz | tar xvz -C build/consul-replicate/usr/sbin )

build/consul-template/usr/sbin/consul-template:
	@( echo "Downloading consul-template ${TEMPLATE_VERSION}" )
	@( mkdir -p build/consul-template/usr/sbin )
	@( curl -s https://releases.hashicorp.com/consul-template/${TEMPLATE_VERSION}/consul-template_${TEMPLATE_VERSION}_linux_${ARCH}.tgz | tar xvz -C build/consul-template/usr/sbin )

build/envconsul/usr/sbin/envconsul:
	@( echo "Downloading envconsul ${ENVCONSUL_VERSION}" )
	@( mkdir -p build/envconsul/usr/sbin )
	@( curl -s https://releases.hashicorp.com/envconsul/${ENVCONSUL_VERSION}/envconsul_${ENVCONSUL_VERSION}_linux_${ARCH}.tgz | tar xvz -C build/envconsul/usr/sbin )

build/hashi-ui/usr/sbin/hashi-ui:
	@( echo "Downloading hashi-ui ${HASHIUI_VERSION}" )
	@( mkdir -p build/hashi-ui/usr/sbin )
	@( curl -s -o build/hashi-ui/usr/sbin/hashi-ui -L https://github.com/jippi/hashi-ui/releases/download/v${HASHIUI_VERSION}/hashi-ui-linux-amd64 )
	@( chmod a+x build/hashi-ui/usr/sbin/hashi-ui )

build/nomad/usr/sbin/nomad:
	@( echo "Downloading nomad ${NOMAD_VERSION}" )
	@( mkdir -p build/nomad/usr/sbin )
	@( curl -s -o /tmp/nomad_${NOMAD_VERSION}_linux_${ARCH}.zip -L https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_${ARCH}.zip )
	@( unzip -q -d build/nomad/usr/sbin/ /tmp/nomad_${NOMAD_VERSION}_linux_${ARCH}.zip )
	@( rm /tmp/nomad_${NOMAD_VERSION}_linux_${ARCH}.zip )

build/packer/usr/bin/packer:
	@( echo "Downloading packer ${PACKER_VERSION}" )
	@( mkdir -p build/packer/usr/bin )
	@( curl -s -o /tmp/packer_${PACKER_VERSION}_linux_${ARCH}.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_${ARCH}.zip )
	@( unzip -q -d build/packer/usr/bin/ /tmp/packer_${PACKER_VERSION}_linux_${ARCH}.zip )
	@( rm /tmp/packer_${PACKER_VERSION}_linux_${ARCH}.zip )

build/vault/usr/sbin/vault:
	@( echo "Downloading vault ${VAULT_VERSION}" )
	@( mkdir -p build/vault/usr/sbin )
	@( curl -s -o /tmp/vault_${VAULT_VERSION}_linux_${ARCH}.zip -L https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_${ARCH}.zip )
	@( unzip -q -d build/vault/usr/sbin/ /tmp/vault_${VAULT_VERSION}_linux_${ARCH}.zip )
	@( rm /tmp/vault_${VAULT_VERSION}_linux_${ARCH}.zip )
