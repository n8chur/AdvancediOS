#!/bin/bash

if which swiftlint >/dev/null; then
  if [ "$ENV" = "CI" ]; then
    echo "warning: Skipping SwiftLint because ENV is CI"
  else 
    swiftlint
  fi
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
