#!/bin/bash

set -ex

version=$(cat VERSION)
image="imroc/grafana-dashboards-git-syncer"

function build() {
	docker build -t ${image}:${version} .
}

function push() {
	docker push ${image}:${version}
}

function all() {
	build
	push
}

$1
