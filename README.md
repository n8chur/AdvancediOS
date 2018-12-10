# AdvancediOS

AdvancediOS demonstrates some advanced concepts for iOS application development using a small example application.

Advanced concepts include:
- [Functional Reactive Programming](https://en.wikipedia.org/wiki/Functional_reactive_programming)
- Project management with [Xcodegen](https://www.github.com/yonaskolb/XcodeGen)
- [MVVM application architecture](https://en.wikipedia.org/wiki/Model–view–viewmodel)
- [Coordinator pattern](https://will.townsend.io/2016/an-ios-coordinator-pattern)
- [Continuous Integration](https://en.wikipedia.org/wiki/Continuous_integration) with [CircleCI](https://circleci.com) and [Fastlane](https://fastlane.tools)
- [BDD](https://en.wikipedia.org/wiki/Behavior-driven_development) style unit testing
- UI Theming
- Programmatic UI
- Using internal frameworks for more modular code
- [Carthage](https://github.com/Carthage/Carthage) for iOS dependency management with caching support using [Rome](https://github.com/blender/Rome)
- Version pinning of as many tooling dependencies as possible using [Mint](https://github.com/yonaskolb/Mint) and [Bundler](https://bundler.io).

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
2. Open `Application.xcodeproj`

### Notes

- Run `$ bundle exec fastlane` for a list of [Fastlane](https://fastlane.tools) lanes that can be run on the repository.
- `Application.xcodeproj` should be used for general development for building a release build.
- `Application_Dev.xcworkspace` is only useful when debugging issues in Carthage dependencies since the Carthage dependency's project is added instead of using pre-built framework.
