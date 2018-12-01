#!/bin/bash

if [ "$ENV" = "CI" ]; then
  echo "warning: Skipping SwiftLint because ENV is CI"
else
  swiftlint --config "../.swiftlint.yml"
fi
