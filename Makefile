generate:
	tuist install
	tuist generate

clear:
	tuist clean
	rm -rf **/**/**/*.xcodeproj
	rm -rf **/**/*.xcodeproj
	rm -rf **/*.xcodeproj
	rm -rf *.xcworkspace
	rm -rf **/**/**/Derived
	rm -rf **/**/Derived
	rm -rf **/Derived
