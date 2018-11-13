XCODEGEN_VERSION=1.9.0
PROJECT_NAME=BestPractices

.PHONY: bootstrap genproj link regenproj

bootstrap: 
	brew bundle
	bundle install
	carthage bootstrap --platform ios
	make genproj

genproj: 
	mint run yonaskolb/XcodeGen@$(XCODEGEN_VERSION) xcodegen --spec project.yml

autocorrect: 
	swiftlint autocorrect

lint:
	swiftlint lint --strict

regenproj:
	rm -rf "$(PROJECT_NAME).xcodeproj"
	make genproj

test: lint
