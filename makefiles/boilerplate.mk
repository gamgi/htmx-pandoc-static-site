SHELL 				 	 = /bin/sh
.SHELLFLAGS 			:= -eu -o pipefail -c  

.DEFAULT_GOAL			:= help

MAKEFLAGS 				+= --warn-undefined-variables
MAKEFLAGS 				+= --no-builtin-rules

.PHONY: all clean cleanext