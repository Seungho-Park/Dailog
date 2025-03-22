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
import AVFoundation
import RxSwift
import RxCocoa

public final class CameraViewController<VM: CameraViewModel>: DailogViewController<VM>, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private lazy var imagePickerView: UIImagePickerController = {
        let controller = UIImagePickerController()
        controller.sourceType = .camera
        controller.allowsEditing = false
        controller.cameraCaptureMode = .photo
        controller.delegate = self
        return controller
    }()
    
    private let closeAction: PublishRelay<Data?> = .init()
    
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
    
    public override func bind() {
        super.bind()
        
        _ = viewModel.transform(
            input: .init(
                close: closeAction.asObservable()
            )
        )
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        container.pin
            .top()
            .bottom()
        container.flex.layout()
    }
    
    deinit {
        print("Deinit: \(Self.self)")
        imagePickerView.willMove(toParent: self)
        imagePickerView.view.removeFromSuperview()
        imagePickerView.removeFromParent()
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        closeAction.accept(nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage, let data = selectedImage.jpegData(compressionQuality: 1) {
            guard let source = CGImageSourceCreateWithData(data as CFData, nil),
                  let cgImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
                return
            }
            
            let imageDestinationData = NSMutableData()
            guard let imageDestination = CGImageDestinationCreateWithData(imageDestinationData, AVFileType.heic as CFString, 1, nil) else {
                return
            }
            
            let options: [CFString: Any] = [
                kCGImageDestinationLossyCompressionQuality: 1 // 압축 품질 (0.0 ~ 1.0)
            ]
            
            CGImageDestinationAddImage(imageDestination, cgImage, options as CFDictionary)
            CGImageDestinationFinalize(imageDestination)
            
            closeAction.accept(imageDestinationData as Data)
        }
    }
}
