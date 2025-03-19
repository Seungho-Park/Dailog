//
//  GalleryItemViewCell.swift
//  SharedUI
//
//  Created by 박승호 on 3/19/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeaturePhotoInterfaces
import Photos

public final class GalleryItemViewCell: UICollectionViewCell {
    public static let identifier = "GalleryItemViewCell"
    
    private let container = UIView()
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let borderView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.softCoral.cgColor
        view.isHidden = true
        return view
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.backgroundColor = .softCoral
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.layer.masksToBounds = true
        return label
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
            .define { flex in
                flex.addItem(countLabel)
                    .marginTop(10)
                    .marginRight(10)
                    .width(25)
                    .height(25)
            }
            .alignItems(.end)
    }
    
    public func fill(viewModel: GalleryItemViewModel) {
        if let data = viewModel.imageData {
            imageView.image = UIImage(data: data)
        } else {
            imageView.image = UIImage(named: "x.mark")
        }
        
        if let selectedIdx = viewModel.selectedIdx {
            borderView.isHidden = false
            countLabel.text = "\(selectedIdx)"
        } else {
            borderView.isHidden = true
            countLabel.text = nil
        }
        
        countLabel.flex.markDirty()
        container.flex.layout()
    }
    
    public func select(order: Int?) {
        guard let order = order else {
            borderView.isHidden = true
            countLabel.text = nil
            return
        }
        
        borderView.isHidden = false
        countLabel.text = "\(order)"
        
        countLabel.layer.cornerRadius = countLabel.frame.width / 2
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews( )
        
        container.pin.all()
        container.flex.layout()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        countLabel.layer.cornerRadius = countLabel.frame.width/2
        borderView.isHidden = true
        countLabel.text = nil
        imageView.image = nil
    }
    
    required public init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
}
