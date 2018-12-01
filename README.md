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
2. Open `BestPractices/BestPractices.xcodeproj`

### Notes

- Run `$ fastlane` for a list of commands.
- There are project files generated for each dependency and the application target which can be found in their corresponding folder (e.g. `BestPractices/BestPractices.xcodeproj`, `Core/Core.xcodeproj`, etc.).
- `BestPractices/BestPractices.xcodeproj` would be used to build the application for deployment.
- `BestPractices.xcworkspace` can be used to develop features that cross multiple internal dependencies or to debug issues occurring within dependencies while running the application.
    - Note that although the application's unit tests will run while using the workspace, all dependency's unit tests will not. Use the dependency's corresponding project file instead.
