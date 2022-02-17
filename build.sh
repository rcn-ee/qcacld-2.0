#!/bin/bash

ARCH=$(uname -m)
branch="dev"

if [ -f .builddir ] ; then
	if [ -d ./src ] ; then
		rm -rf ./src || true
	fi

	git clone -b ${branch} https://github.com/SanCloudLtd/qcacld-2.0 ./src --depth=1

	if [ "x${ARCH}" = "xarmv7l" ] ; then
		make_options="CROSS_COMPILE= KERNEL_SRC=/build/buildd/linux-src"
	else
		x86_dir="`pwd`/../../normal"
		if [ -f `pwd`/../../normal/.CC ] ; then
			. `pwd`/../../normal/.CC
			make_options="CROSS_COMPILE=${CC} KERNEL_SRC=${x86_dir}/KERNEL"
		fi
	fi

	cd ./src/
	echo "make ARCH=arm ${make_options}"
	make ARCH=arm ${make_options} all
fi
#
