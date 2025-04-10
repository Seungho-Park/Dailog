// swift-tools-version: 6.0
@preconcurrency import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,]
        productTypes: [:]
    )
#endif

let package = Package(
    name: "Dailog",
    dependencies: [
        .package(url: "https://github.com/layoutBox/PinLayout.git", .upToNextMajor(from: "1.10.5")),
        .package(url: "https://github.com/layoutBox/FlexLayout.git", .upToNextMajor(from: "1.3.18")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.9.0")),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", .upToNextMajor(from: "11.8.1")),
        .package(url: "https://github.com/ChartsOrg/Charts.git", .upToNextMajor(from: "5.1.0")),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git", .upToNextMajor(from: "12.2.0"))
    ]
)
