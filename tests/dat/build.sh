#!/bin/bash
set -e


../../tools/build/compile.sh  HelloSwift4 swift:4 "-v"

../../tools/build/compile.sh  SwiftyRequest swift:4 "-v"

