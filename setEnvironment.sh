#!/usr/bin/env bash

export PROJECTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export JAVA_HOME="$PROJECTDIR"/java
METAFACTURE_HOME=$PROJECTDIR

export PATH=$JAVA_HOME/bin:.:$PATH


