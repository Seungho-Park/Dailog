import ProjectDescription
import ProjectDescriptionHelpers
import ModuleDependencies

let project: Project = .makeProject(
    name: "FeatureHome",
    targets: [
        .feature(
            interface: .home,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .home,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .home),
                ]
            )
        ),
        .feature(
            testing: .home,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .home)
                ]
            )
        ),
        .feature(
            tests: .home,
            factory: .init(
                dependencies: [
                    .feature(implements: .home),
                    .feature(testing: .home)
                ]
            )
        ),
        .feature(
            example: .home,
            factory: .init(
                dependencies: [
                    .feature(implements: .home)
                ]
            )
        )
    ]
)
