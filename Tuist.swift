import ProjectDescription

let tuist = Tuist(
    project: .tuist(
        compatibleXcodeVersions: [
            .upToNextMajor("16.0")
        ],
        swiftVersion: "6.0",
        plugins: [
            .local(path: .relativeToRoot("Plugins/ModulePlugin")),
            .local(path: .relativeToRoot("Plugins/ThirdPartyLibs"))
        ],
        generationOptions: .options(),
        installOptions: .options()
    )
)
