import ProjectDescription
import ProjectDescriptionHelpers
import ModuleDependencies

let project: Project = .makeProject(
    name: "FeatureSettings",
    targets: [
        .feature(
            interface: .settings,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .settings,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .settings),
                ]
            )
        ),
        .feature(
            testing: .settings,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .settings)
                ]
            )
        ),
        .feature(
            tests: .settings,
            factory: .init(
                dependencies: [
                    .feature(implements: .settings),
                    .feature(testing: .settings)
                ]
            )
        ),
        .feature(
            example: .settings,
            factory: .init(
                dependencies: [
                    .feature(implements: .settings)
                ]
            )
        )
    ]
)
