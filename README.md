# AdvancediOS [![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/n8chur/AdvancediOS/master/LICENSE.md) [![CircleCI](https://circleci.com/gh/n8chur/AdvancediOS/tree/master.svg?style=svg)](https://circleci.com/gh/n8chur/AdvancediOS/tree/master)

AdvancediOS demonstrates some advanced concepts for iOS application development using a small example application.

Advanced concepts include:
- A unique application architecture that takes inspiration from [MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel), [FRP](https://en.wikipedia.org/wiki/Functional_reactive_programming), [Coordinator Pattern](https://will.townsend.io/2016/an-ios-coordinator-pattern), [Factory Pattern](https://en.wikipedia.org/wiki/Factory_(object-oriented_programming)), [Dependency Injection](https://en.wikipedia.org/wiki/Dependency_injection), and [Protocol Oriented Programming](https://www.toptal.com/swift/introduction-protocol-oriented-programming-swift)
- [XcodeGen](https://www.github.com/yonaskolb/XcodeGen) for generating an Xcode project
- Type safe code generation for assets, plists, and localized string references using [SwiftGen](https://github.com/SwiftGen/SwiftGen)
- Linting with [SwiftLint](https://github.com/realm/SwiftLint)
- Basic localization
- [Continuous Integration](https://en.wikipedia.org/wiki/Continuous_integration) with [CircleCI](https://circleci.com) and [Fastlane](https://fastlane.tools)
- [BDD](https://en.wikipedia.org/wiki/Behavior-driven_development) style unit testing
- Dynamic UI theming
- Programmatic UI
- A custom logging framework that leverages [XCGLogger](https://github.com/DaveWoodCom/XCGLogger)
- Using internal frameworks for more modular code
- [Carthage](https://github.com/Carthage/Carthage) for iOS dependency management with caching support using [Rome](https://github.com/blender/Rome)
- Version pinning of as many tooling dependencies as possible using [Mint](https://github.com/yonaskolb/Mint) and [Bundler](https://bundler.io).

This project is mostly intended to be used as a playground to experiment with new tools, libraries, and design patterns for iOS development.

## Setup

### Prerequisites

- Ruby installation matching the version found in [.ruby-version](.ruby-version) (use [rbenv](https://github.com/rbenv/rbenv) to switch versions)
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
- `Application_Dev.xcworkspace` is only useful when debugging issues in Carthage dependencies since the Carthage dependency's project is added instead of using the pre-built framework.

### Contributions

[![](https://sourcerer.io/fame/n8chur/n8chur/AdvancediOS/images/0)](https://sourcerer.io/fame/n8chur/n8chur/AdvancediOS/links/0)[![](https://sourcerer.io/fame/n8chur/n8chur/AdvancediOS/images/1)](https://sourcerer.io/fame/n8chur/n8chur/AdvancediOS/links/1)[![](https://sourcerer.io/fame/n8chur/n8chur/AdvancediOS/images/2)](https://sourcerer.io/fame/n8chur/n8chur/AdvancediOS/links/2)[![](https://sourcerer.io/fame/n8chur/n8chur/AdvancediOS/images/3)](https://sourcerer.io/fame/n8chur/n8chur/AdvancediOS/links/3)[![](https://sourcerer.io/fame/n8chur/n8chur/AdvancediOS/images/4)](https://sourcerer.io/fame/n8chur/n8chur/AdvancediOS/links/4)[![](https://sourcerer.io/fame/n8chur/n8chur/AdvancediOS/images/5)](https://sourcerer.io/fame/n8chur/n8chur/AdvancediOS/links/5)[![](https://sourcerer.io/fame/n8chur/n8chur/AdvancediOS/images/6)](https://sourcerer.io/fame/n8chur/n8chur/AdvancediOS/links/6)[![](https://sourcerer.io/fame/n8chur/n8chur/AdvancediOS/images/7)](https://sourcerer.io/fame/n8chur/n8chur/AdvancediOS/links/7)
