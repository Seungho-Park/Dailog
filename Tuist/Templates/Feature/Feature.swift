//
//  Feature.swift
//  Manifests
//
//  Created by 박승호 on 5/7/25.
//

import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")

let featureTemplate = Template(
    description: "Feature Module Template",
    attributes: [
        nameAttribute
    ],
    items: [
        .file(
            path: "Projects/Feature/\(nameAttribute)/Project.swift",
            templatePath: "Stencil/Project.stencil"
        ),
        .file(
            path: "Projects/Feature/\(nameAttribute)/Interfaces/Sources/\(nameAttribute)Dependency.swift",
            templatePath: "Stencil/Dependency.stencil"
        ),
        .file(
            path: "Projects/Feature/\(nameAttribute)/Sources/\(nameAttribute)Component.swift",
            templatePath: "Stencil/Component.stencil"
        ),
        .file(
            path: "Projects/Feature/\(nameAttribute)/Sources/\(nameAttribute)Export.swift",
            templatePath: "Stencil/Export.stencil"
        ),
        .file(
            path: "Projects/Feature/\(nameAttribute)/Sources/Default\(nameAttribute)SceneFlowCoordinator.swift",
            templatePath: "Stencil/Coordinator.stencil"
        ),
        .file(
            path: "Projects/Feature/\(nameAttribute)/Interfaces/Sources/\(nameAttribute)SceneFlowCoordinator.swift",
            templatePath: "Stencil/CoordinatorInterface.stencil"
        ),
        .file(
            path: "Projects/Feature/\(nameAttribute)/Example/Sources/AppDelegate.swift",
            templatePath: "Stencil/AppDelegate.stencil"
        ),
        .file(
            path: "Projects/Feature/\(nameAttribute)/Example/Sources/SceneDelegate.swift",
            templatePath: "Stencil/SceneDelegate.stencil"
        ),
        .file(
            path: "Projects/Feature/\(nameAttribute)/Testing/Sources/Content.swift",
            templatePath: "Stencil/Content.stencil"
        ),
        .file(
            path: "Projects/Feature/\(nameAttribute)/Tests/Sources/Content.swift",
            templatePath: "Stencil/Content.stencil"
        )
    ]
)
