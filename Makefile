PREFIX?=/usr/local

.PHONY: xcodeproj
xcodeproj:
	swift package generate-xcodeproj --output ./SwiftMocka.xcodeproj

.PHONY: build
build:
	swift build

.PHONY: release-build
release-build:
	swift build -c release -Xswiftc -static-stdlib

.PHONY: release-build
install: build
	mkdir -p "$(PREFIX)/bin"
	cp -f ".build/release/mocka" "$(PREFIX)/bin/mocka"
