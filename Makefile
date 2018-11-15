XCODEGEN_VERSION=2.0.0
PROJECT_NAME=BestPractices

.PHONY: bootstrap genproj link regenproj

autocorrect: 
	swiftlint autocorrect

bootstrap: 
	brew bundle
	bundle install
	carthage bootstrap --platform ios
	make genproj

genproj: 
	mint run yonaskolb/XcodeGen@$(XCODEGEN_VERSION) xcodegen --spec project.yml

lint: 
	swiftlint lint --strict

regenproj:
	rm -rf "$(PROJECT_NAME).xcodeproj"
	make genproj

test: 
	bundle exec fastlane test
