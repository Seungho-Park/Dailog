//
//  PhotoSceneFlowCoordinator.swift
//  Manifests
//
//  Created by 박승호 on 3/19/25.
//

import SharedUIInterfaces

public protocol PhotoSceneFlowCoordinatorDependencies {    
    func makeGalleryViewModel(actions: GalleryViewModelAction)-> any GalleryViewModel
}

public protocol PhotoSceneFlowCoordinator: Coordinator {
    var dependencies: PhotoSceneFlowCoordinatorDependencies { get }
}
