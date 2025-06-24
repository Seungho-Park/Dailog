import ProjectDescription

let tuist: Tuist = .init(
    project: .tuist(
        compatibleXcodeVersions: .upToNextMajor("16.0"),
        swiftVersion: "6.0",
        plugins: [
            .local(path: .relativeToRoot("Plugins/ModuleDependencies"))
        ],
        generationOptions: .options(),
        installOptions: .options()
    )
)
