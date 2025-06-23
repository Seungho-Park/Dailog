import ProjectDescription

let project = Project(
    name: "Dailog",
    targets: [
        .target(
            name: "Dailog",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.Dailog",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Dailog/Sources/**"],
            resources: ["Dailog/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "DailogTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.DailogTests",
            infoPlist: .default,
            sources: ["Dailog/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Dailog")]
        ),
    ]
)
