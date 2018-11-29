#!/bin/bash

if [ "$ENV" = "CI" ]; then
  echo "warning: Skipping SwiftLint because ENV is CI"
else
  # Since this script is run from project root we need to push into the target's directory first.
  pushd "BestPractices"
    swiftlint --config "../.swiftlint.yml"
  popd
fi
