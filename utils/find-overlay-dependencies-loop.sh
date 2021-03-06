#!/bin/bash
#===--- find-overlay-dependencies-loop.sh - driver for find-overlay-dependency.sh---===#
#
## This source file is part of the Swift.org open source project
##
## Copyright (c) 2016 Apple Inc. and the Swift project authors
## Licensed under Apache License v2.0 with Runtime Library Exception
##
## See http://swift.org/LICENSE.txt for license information
## See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
#
#===------------------------------------------------------------------------===#

SCRIPT="$(dirname "$0")/find-overlay-dependencies.sh"

# `update` edits the cmake file in-place; `print` just prints to console
function usage() {
  echo 'usage:' $0 'update|print' >&2
    exit 1
}

case $# in
1) if [[ $1 != 'update' && $1 != 'print' ]]; then
    usage
  fi ;;
*)
  usage ;;
esac

# Don't update XCTest
for overlay in $(find ./stdlib/public/SDK/ -depth 1 -type d ! -name XCTest -exec basename \{\} \;); do
  $SCRIPT $overlay $1
done
