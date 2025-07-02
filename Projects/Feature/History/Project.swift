import ProjectDescription
import ProjectDescriptionHelpers
import ModuleDependencies

let project: Project = .makeProject(
    name: "FeatureHistory",
    targets: [
        .feature(
            interface: .history,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .history,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .history),
                ]
            )
        ),
        .feature(
            testing: .history,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .history)
                ]
            )
        ),
        .feature(
            tests: .history,
            factory: .init(
                dependencies: [
                    .feature(implements: .history),
                    .feature(testing: .history)
                ]
            )
        ),
        .feature(
            example: .history,
            factory: .init(
                dependencies: [
                    .feature(implements: .history)
                ]
            )
        )
    ]
)
