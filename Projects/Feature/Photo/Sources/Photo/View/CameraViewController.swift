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
        guard let selectedImage = info[.originalImage] as? UIImage,
              let fixedImage = selectedImage.fixedOrientation(),
              let imageData = fixedImage.jpegData(compressionQuality: 1),
              let source = CGImageSourceCreateWithData(imageData as CFData, nil),
              let cgImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
            return
        }
        
        let destinationData = NSMutableData()
        guard let imageDestination = CGImageDestinationCreateWithData(destinationData, AVFileType.heic as CFString, 1, nil) else {
            return
        }
        
        CGImageDestinationAddImage(imageDestination, cgImage, [kCGImageDestinationLossyCompressionQuality: 1] as CFDictionary)
        CGImageDestinationFinalize(imageDestination)
        
        closeAction.accept(destinationData as Data)
    }
}

private extension UIImage {
    func fixedOrientation() -> UIImage? {
        guard imageOrientation != .up else { return self }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
