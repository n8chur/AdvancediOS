XCODEGEN_VERSION=2.0.0
PROJECT_NAME=BestPractices

.PHONY: autocorrect bootstrap carthage_bootstrap genproj link regenproj

autocorrect: 
	swiftlint autocorrect

bootstrap: 
	brew bundle
	bundle install
	bundle exec carthage bootstrap --platform ios
	make genproj

carthage_bootstrap:
	bundle exec rome download --platform iOS
	bundle exec rome list --missing --platform ios | awk '{print $$1}' | xargs carthage build --platform ios --cache-builds
	bundle exec rome list --missing --platform ios | awk '{print $$1}' | xargs rome upload --platform ios

carthage_checkout:
	bundle exec carthage checkout

carthage_update:
	bundle exec carthage update --platform ios --no-build

genproj: 
	mint run yonaskolb/XcodeGen@$(XCODEGEN_VERSION) xcodegen --spec project.yml

lint: 
	swiftlint lint --strict

regenproj:
	rm -rf "$(PROJECT_NAME).xcodeproj"
	make genproj

test: 
	bundle exec fastlane test
