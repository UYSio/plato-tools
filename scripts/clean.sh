#!/usr/bin/env bash

source scripts/dev-config
echo "$0 >> Deleting $OUT_ROOT and $OUT_ENTRIES"
rm -rf $OUT_ROOT
rm -rf $OUT_ENTRIES
