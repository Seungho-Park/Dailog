// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        productTypes: [:]
    )
#endif

let package = Package(
    name: "Dailog",
    dependencies: [
        .package(url: "https://github.com/uber/needle.git", .upToNextMajor(from: "0.25.1")),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "11.15.0")),
        .package(url: "https://github.com/layoutBox/FlexLayout.git", from: "1.3.18"),
        .package(url: "https://github.com/layoutBox/PinLayout.git", from: "1.10.5")
    ]
)
