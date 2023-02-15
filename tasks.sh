#!/bin/bash

os=$(uname -s)
arch=$(uname -m)
preflight_current_version="v0.57.1"
url="https://github.com/replicatedhq/troubleshoot/releases/download"
preflight_yaml="https://raw.githubusercontent.com/chasehainey/sandbox/main/preflightyaml"
supportbundle_yaml="https://raw.githubusercontent.com/chasehainey/sandbox/main/support-bundle.yaml"

cleanup(){
	if [ -f /tmp/LICENSE ]
	then
		rm /tmp/LICENSE
	fi
	if [ -f /tmp/README.md ]
	then
		rm /tmp/README.md
	fi
	if [ -f /tmp/key.pub ]
	then
		rm /tmp/key.pub
	fi
	if [ -f /tmp/troubleshoot-sbom.tgz ]
	then
		rm /tmp/troubleshoot-sbom.tgz*
	fi
	if [ -f /tmp/preflight ]
	then
		rm /tmp/preflight*
	fi
	if [ -f /tmp/support-bundle ]
	then
		rm /tmp/support-bundle*
	fi
}

preflight_linux_os_x86_64(){
	echo "Replicated Preflight loading for Linux x86_64..."
	wget -q -P /tmp $url/$preflight_current_version/preflight_linux_amd64.tar.gz
	tar zxf /tmp/preflight_linux_amd64.tar.gz -C /tmp
	wget -q -P /tmp $preflight_yaml
	/tmp/preflight /tmp/preflight.yaml
	cleanup
}

preflight_linux_os_arm64(){
	echo "Replicated Preflight loading for Linux arm64..."
	wget -q -P /tmp $url/$preflight_current_version/preflight_linux_arm64.tar.gz
	tar zxf /tmp/preflight_linux_arm64.tar.gz -C /tmp
	wget -q -P /tmp $preflight_yaml
	/tmp/preflight /tmp/preflight.yaml
	cleanup
}

preflight_macos_arm64(){
	echo "Replicated Preflight loading for macOS arm64..."
	wget -q -P /tmp $url/$preflight_current_version/preflight_darwin_arm64.tar.gz
	tar zxf /tmp/preflight_darwin_arm64.tar.gz -C /tmp
	wget -q -P /tmp $preflight_yaml
	/tmp/preflight /tmp/preflight.yaml
	cleanup
}

preflight_macos_x86_64(){
	echo "Replicated Preflight loading for macOS x86_64..."
	wget -q -P /tmp $url/$preflight_current_version/preflight_darwin_amd64.tar.gz
	tar zxf /tmp/preflight_darwin_amd64.tar.gz -C /tmp
	wget -q -P /tmp $preflight_yaml
	/tmp/preflight /tmp/preflight.yaml
	cleanup
}

supportbundle_linux_os_x86_64(){
	echo "Replicated Support Bundle loading for Linux x86_64..."
	wget -q -P /tmp $url/$preflight_current_version/support-bundle_linux_amd64.tar.gz
	tar zxf /tmp/support-bundle_linux_amd64.tar.gz -C /tmp
	wget -q -P /tmp $supportbundle_yaml
	/tmp/support-bundle /tmp/support-bundle.yaml
	cleanup
}

supportbundle_linux_os_arm64(){
	echo "Replicated Support Bundle loading for Linux arm64..."
	wget -q -P /tmp $url/$preflight_current_version/support-bundle_linux_arm64.tar.gz
	tar zxf /tmp/support-bundle_linux_arm64.tar.gz -C /tmp
	wget -q -P /tmp $supportbundle_yaml
	/tmp/support-bundle /tmp/support-bundle.yaml
	cleanup
}

supportbundle_macos_arm64(){
	echo "Replicated Support Bundle loading for macOS arm64..."
	wget -q -P /tmp $url/$preflight_current_version/support-bundle_darwin_arm64.tar.gz
	tar zxf /tmp/support-bundle_darwin_arm64.tar.gz -C /tmp
	wget -q -P /tmp $supportbundle_yaml
	/tmp/support-bundle /tmp/support-bundle.yaml
	cleanup
}

supportbundle_macos_x86_64(){
	echo "Replicated Support Bundle loading for macOS x86_64..."
	wget -q -P /tmp $url/$preflight_current_version/support-bundle_darwin_amd64.tar.gz
	tar zxf /tmp/support-bundle_darwin_amd64.tar.gz -C /tmp
	wget -q -P /tmp $supportbundle_yaml
	/tmp/support-bundle /tmp/support-bundle.yaml
	cleanup
}

preflight(){
	if [ $os == "Linux" ] && [ $arch == "x86_64" ]
	then
		preflight_linux_os_x86_64
	elif [ $os == "Linux" ] && ([ $arch == "arm64"] || [ $arch == "aarch64" ])
	then
		preflight_linux_os_arm64
	elif [ $os == "Darwin" ] && ([ $arch == "arm64" ] || [ $arch == "aarch64" ])
	then
		preflight_macos_arm64
	elif [ $os == "Darwin" ] && [ $arch == "x86_64" ]
	then
		preflight_macos_x86_64
	fi
}

supportbundle(){
	if [ $os == "Linux" ] && [ $arch == "x86_64" ]
	then
		supportbundle_linux_os_x86_64
	elif [ $os == "Linux" ] && ([ $arch == "arm64"] || [ $arch == "aarch64" ])
	then
		supportbundle_linux_os_arm64
	elif [ $os == "Darwin" ] && ([ $arch == "arm64" ] || [ $arch == "aarch64" ])
	then
		supportbundle_macos_arm64
	elif [ $os == "Darwin" ] && [ $arch == "x86_64" ]
	then
		supportbundle_macos_x86_64
	fi
}

if [ $1 == "preflight" ]
then
	preflight
elif [ $1 == "supportbundle" ]
then
	supportbundle
else
	echo "Command not recognized."
fi
