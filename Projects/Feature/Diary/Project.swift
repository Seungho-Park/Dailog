import ProjectDescription
import ProjectDescriptionHelpers
import ModuleDependencies

let project: Project = .makeProject(
    name: "FeatureDiary",
    targets: [
        .feature(
            interface: .diary,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .diary,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .diary),
                ]
            )
        ),
        .feature(
            testing: .diary,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .diary)
                ]
            )
        ),
        .feature(
            tests: .diary,
            factory: .init(
                dependencies: [
                    .feature(implements: .diary),
                    .feature(testing: .diary)
                ]
            )
        ),
        .feature(
            example: .diary,
            factory: .init(
                dependencies: [
                    .feature(implements: .diary)
                ]
            )
        )
    ]
)
