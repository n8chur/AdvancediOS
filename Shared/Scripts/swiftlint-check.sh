#!/bin/bash

if [ $CIRCLECI ]; then
  echo "warning: Skipping SwiftLint because ENV is CI"
else
  # Only check the directory that matches the product name that's being built.
  pushd "$PRODUCT_NAME"
    swiftlint --config "../.swiftlint.yml"
  popd
fi