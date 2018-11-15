XCODEGEN_VERSION=2.0.0
PROJECT_NAME=BestPractices

.PHONY: bootstrap build_static genproj autocorrect link regenproj test

bootstrap: 
	brew bundle
	bundle install
	carthage checkout
	make build_static
	make genproj

build_static:
	./Scripts/carthage-build-static.sh --platform ios

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
