#!/bin/bash

os=$(uname -s)
arch=$(uname -m)
current_version="v0.57.1"
url="https://github.com/replicatedhq/troubleshoot/releases/download"
preflight_yaml="https://raw.githubusercontent.com/replicatedhq/troubleshoot/main/examples/preflight/sample-preflight.yaml"

linux_os_x86_64(){
	echo "Replicated Preflight loading for Linux x86_64..."
	wget -q -P /tmp $url/$current_version/preflight_linux_amd64.tar.gz
	tar zxf /tmp/preflight_linux_amd64.tar.gz -C /tmp
	wget -q -P /tmp $preflight_yaml
	/tmp/preflight /tmp/sample-preflight.yaml
	rm /tmp/LICENSE /tmp/README.md /tmp/key.pub /tmp/troubleshoot-sbom.tgz* /tmp/preflight* /tmp/sample-preflight*
}

linux_os_arm64(){
	echo "Replicated Preflight loading for Linux arm64..."
	wget -q -P /tmp $url/$current_version/preflight_linux_arm64.tar.gz
	tar zxf /tmp/preflight_linux_arm64.tar.gz -C /tmp
	wget -q -P /tmp $preflight_yaml
	/tmp/preflight /tmp/sample-preflight.yaml
	rm /tmp/LICENSE /tmp/README.md /tmp/key.pub /tmp/troubleshoot-sbom.tgz* /tmp/preflight* /tmp/sample-preflight*
}

macos_arm64(){
	echo "Replicated Preflight loading for macOS arm64..."
	wget -q -P /tmp $url/$current_version/preflight_darwin_arm64.tar.gz
	tar zxf /tmp/preflight_darwin_arm64.tar.gz -C /tmp
	wget -q -P /tmp $preflight_yaml
	/tmp/preflight /tmp/sample-preflight.yaml
	rm /tmp/LICENSE /tmp/README.md /tmp/key.pub /tmp/troubleshoot-sbom.tgz* /tmp/preflight* /tmp/sample-preflight*
}

macos_x86_64(){
	echo "Replicated Preflight loading for macOS x86_64..."
	wget -q -P /tmp $url/$current_version/preflight_darwin_amd64.tar.gz
	tar zxf /tmp/preflight_darwin_amd64.tar.gz -C /tmp
	wget -q -P /tmp $preflight_yaml
	/tmp/preflight /tmp/sample-preflight.yaml
	rm /tmp/LICENSE /tmp/README.md /tmp/key.pub /tmp/troubleshoot-sbom.tgz* /tmp/preflight* /tmp/sample-preflight*
}

if [ $os == "Linux" ] && [ $arch == "x86_64" ]
then
	linux_os_x86_64
elif [ $os == "Linux" ] && ([ $arch == "arm64"] || [ $arch == "aarch64" ])
then
	linux_os_arm64
elif [ $os == "Darwin" ] && ([ $arch == "arm64" ] || [ $arch == "aarch64" ])
then
	macos_arm64
elif [ $os == "Darwin" ] && [ $arch == "x86_64" ]
then
	macos_x86_64
fi