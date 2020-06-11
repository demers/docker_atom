TARGETS := $(shell cat $(realpath $(lastword $(MAKEFILE_LIST))) | grep "^[a-z]*:" | awk '{ print $$1; }' | sed 's/://g' | grep -vE 'all|help' | paste -sd "|" -)
NAME := $(subst docker-,,$(shell basename $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))))
IMAGE := codeworksio/$(NAME)

all: help

help:
	echo
	echo "Usage:"
	echo
	echo "    make create"
	echo
	echo " to create Dockerfile"

create:
	./dockerfile.bash

.SILENT: help
