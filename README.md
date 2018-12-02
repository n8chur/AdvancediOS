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

- Run `$ fastlane` for a list of commands.
- There are project files generated for each dependency and the application target which can be found in their corresponding folder (e.g. `BestPractices.xcodeproj`, `Core/Core.xcodeproj`, etc.).
- `BestPractices.xcodeproj` would be used to build the application for deployment.
- There are project files for each internal dependency which could be used if you're only working within a single framework during development.
-- Note that unit tests for internal dependencies must be run in their corresponding project file. They cannot be run from projects that depend on them.
- `BestPractices.xcworkspace` is useful when debugging issues in Carthage dependencies since the Carthage dependency's project is added instead of using pre-built framework.
