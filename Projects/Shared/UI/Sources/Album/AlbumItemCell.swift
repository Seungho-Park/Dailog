//
//  AlbumItemCell.swift
//  SharedUI
//
//  Created by 박승호 on 3/19/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import Photos

public final class AlbumItemCell: UICollectionViewCell {
    public static let identifier = "AlbumItemCell"
    
    public override var isSelected: Bool {
        didSet {
            borderView.isHidden = !isSelected
        }
    }
    
    private let container = UIView()
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let borderView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.softCoral.cgColor
        view.isHidden = true
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        focusEffect = nil
        contentView.addSubview(container)
        contentView.layer.masksToBounds = true
        
        container.flex
            .addItem(imageView)
            .grow(1)
        
        container
            .flex
            .addItem(borderView)
            .position(.absolute)
            .horizontally(0)
            .vertically(0)
    }
    
    public func fill(viewModel: AlbumItemCellViewModel) {
        let imageManager = PHImageManager.default()
            
        let targetSize = CGSize(width: self.bounds.width * 2, height: self.bounds.height * 2)
            
        let options = PHImageRequestOptions()
        options.isSynchronous = false
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
            
        imageManager.requestImage(for: viewModel.photo, targetSize: targetSize, contentMode: .aspectFill, options: options) { [weak self] image, _ in
            self?.imageView.image = image
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews( )
        
        container.pin.all()
        container.flex.layout()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    required public init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
}
