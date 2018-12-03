# BestPracticesiOS

BestPracticesiOS is a repository that represents a basic Swift iOS app that utilizes best practices for Xcode development.

This project uses [functional reactive programming](https://en.wikipedia.org/wiki/Functional_reactive_programming) inspired concepts (with [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa)), although this is not necessarily a best practice for every project.

This project is mostly intended to be used as a playground to experiment with new tools, libraries, and design patterns for iOS development.

## Setup

### Prerequisites

- Ruby installation matching the version found in [.ruby-version](.ruby-version) (use [RVM](https://rvm.io/rvm/basics) to switch versions)
- [Homebrew](https://brew.sh)
- [Bundler](https://bundler.io)
- Xcode installation matching version found in [.xcode-version](.xcode-version) (use [xcode-install](https://github.com/KrauseFx/xcode-install) to switch versions)

### Installation

1. Setup the project:
```
$ brew bundle && bundle install
$ bundle exec fastlane bootstrap
```
2. Open `BestPractices.xcodeproj`

### Notes

- Run `$ bundle exec fastlane` for a list of [Fastlane](https://fastlane.tools) lanes that can be run on the repository.
- `BestPractices.xcodeproj` should be used for general development for building a release build.
- `BestPractices_Dev.xcworkspace` is only useful when debugging issues in Carthage dependencies since the Carthage dependency's project is added instead of using pre-built framework.
