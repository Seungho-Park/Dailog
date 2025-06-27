import ProjectDescription

let tuist: Tuist = .init(
    project: .tuist(
        compatibleXcodeVersions: .upToNextMajor("16.0"),
        swiftVersion: "6.0",
        plugins: [
            .local(path: .relativeToRoot("Plugins/ModuleDependencies")),
            .local(path: .relativeToRoot("Plugins/ThirdPartyDependencies"))
        ],
        generationOptions: .options(),
        installOptions: .options()
    )
)
