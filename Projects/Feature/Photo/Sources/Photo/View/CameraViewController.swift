//
//  CameraViewController.swift
//  FeaturePhoto
//
//  Created by 박승호 on 3/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import FeaturePhotoInterfaces
import SharedUI
import UIKit

public final class CameraViewController<VM: CameraViewModel>: DailogViewController<VM>, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private lazy var imagePickerView: UIImagePickerController = {
        let controller = UIImagePickerController()
        controller.sourceType = .camera
        controller.allowsEditing = false
        controller.cameraCaptureMode = .photo
        controller.delegate = self
        return controller
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func configure() {
        super.configure()
        
        self.addChild(imagePickerView)
        self.container.flex
            .addItem(imagePickerView.view)
            .grow(1)
        imagePickerView.didMove(toParent: self)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        container.pin
            .top()
            .bottom()
        container.flex.layout()
    }
    
    deinit {
        imagePickerView.willMove(toParent: self)
        imagePickerView.view.removeFromSuperview()
        imagePickerView.removeFromParent()
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
    }
}
