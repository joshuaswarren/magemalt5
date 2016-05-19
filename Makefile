all: clean build

validate:
	packer validate magemalt5.json

build: validate
	packer build magemalt5.json

build-vbox: validate
	packer build -only=vbox magemalt5.json

build-vmware: validate
	packer build -only=vmware magemalt5.json

clean:
	rm -rf output-*
	rm -rf *.box

clean-all: clean
	rm -rf packer_cache

install:
	vagrant box add magemalt5-vbox ./magemalt5.box --provider virtualbox --force || true
	vagrant box add magemalt5-vmware ./magemalt5-vmware.box --provider vmware_desktop --force || true
	vagrant box list | grep magemalt5
	@echo Boxes have been installed. Run make clean-all to reclaim disk space.
