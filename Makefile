SHELL := /bin/bash

all:
	./control.sh all

%:
	./control.sh $@