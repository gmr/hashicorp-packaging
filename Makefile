CONSUL_VERSION=0.9.2
REPLICATE_VERSION=0.4.0
TEMPLATE_VERSION=0.19.1
ENVCONSUL_VERSION=0.7.2
HASHIUI_VERSION=0.17.0

CONSUL_ITERATION=1
ENVCONSUL_ITERATION=1
HASHIUI_ITERATION=1
REPLICATE_ITERATION=1
TEMPLATE_ITERATION=1

PACKAGER="Gavin M. Roy <gavinr@aweber.com>"
ARCH=amd64

all: consul consul-replicate consul-template envconsul hashi-ui

clean:
	@( rm -rf build/* )
	@( rm -rf dist/* )

consul: dist/consul_${CONSUL_VERSION}-${CONSUL_ITERATION}_${ARCH}.deb

consul-replicate: dist/consul-replicate_${REPLICATE_VERSION}-${REPLICATE_ITERATION}_${ARCH}.deb

consul-template: dist/consul-template_${TEMPLATE_VERSION}-${TEMPLATE_ITERATION}_${ARCH}.deb

envconsul: dist/envconsul_${ENVCONSUL_VERSION}-${ENVCONSUL_ITERATION}_${ARCH}.deb

hashi-ui: dist/hashi-ui_${HASHIUI_VERSION}-${HASHIUI_ITERATION}_${ARCH}.deb

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
			--package dist/hashi-ui_${HASHIUI_VERSION}-${HASHIUI_ITERATION}_${ARCH}.deb \
			--name hashi-ui --version ${HASHIUI_VERSION} --iteration ${HASHIUI_ITERATION} \
			--deb-changelog changes/hashi-ui \
			--depends consul \
			--category utils \
			--deb-default build/hashi-ui/etc/default/hashi-ui \
			--deb-upstart build/hashi-ui/etc/init/hashi-ui.conf \
			--provides hashi-ui \
			--description "A modern user interface for @hashicorp Consul & Nomad" . )

build/consul/usr/sbin/consul:
	@( echo "Downloading consul ${CONSUL_VERSION}" )
	@( mkdir -p build/consul/usr/sbin/ )
	@( curl -s -o /tmp/${CONSUL_VERSION}_linux_${ARCH}.zip -L https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_${ARCH}.zip )
	@( unzip -q -d build/consul/usr/sbin/ /tmp/${CONSUL_VERSION}_linux_${ARCH}.zip )
	@( rm /tmp/${CONSUL_VERSION}_linux_${ARCH}.zip )

build/consul-replicate/usr/sbin/consul-replicate:
	@( echo "Downloading consul-replicate ${REPLICATE_VERSION}" )
	@( mkdir -p build/consul-replicate/usr/sbin )
	@( curl -s -L https://releases.hashicorp.com/consul-replicate/v${REPLICATE_VERSION}/consul-replicate_v${REPLICATE_VERSION}_linux_{ARCH}.tgz | tar xvz -C build/consul-replicate/usr/sbin --strip-components=1 )

build/consul-template/usr/sbin/consul-template:
	@( echo "Downloading consul-template ${TEMPLATE_VERSION}" )
	@( mkdir -p build/consul-template/usr/sbin )
	@( curl -s -L https://releases.hashicorp.com/consul-template/${TEMPLATE_VERSION}/consul-template_${TEMPLATE_VERSION}_linux_${ARCH}.tgz | tar xvz -C build/consul-template/usr/sbin --strip-components=1 )

build/envconsul/usr/sbin/envconsul:
	@( echo "Downloading envconsul ${ENVCONSUL_VERSION}" )
	@( mkdir -p build/envconsul/usr/sbin )
	@( curl -s -L https://releases.hashicorp.com/envconsul/${ENVCONSUL_VERSION}/envconsul_${ENVCONSUL_VERSION}_linux_${ARCH}.tgz | tar xvz -C build/envconsul/usr/sbin --strip-components=1 )

build/hashi-ui/usr/sbin/hashi-ui:
	@( echo "Downloading hashi-ui ${HASHIUI_VERSION}" )
	@( mkdir -p build/hashi-ui/usr/sbin )
	@( curl -s -o build/hashi-ui/usr/sbin/hashi-ui -L https://github.com/jippi/hashi-ui/releases/download/v${HASHIUI_VERSION}/hashi-ui-linux-amd64 )
	@( chmod a+x build/hashi-ui/usr/sbin/hashi-ui )
