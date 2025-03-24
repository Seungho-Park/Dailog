//
//  DiaryWritePhotoItemCell.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/25/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreStorageInterfaces

public final class DiaryWritePhotoItemCell: UICollectionViewCell {
    public static let identifier = "DiaryWritePhotoItemCell"
    public var disposeBag = DisposeBag()
    
    private let container = UIView()
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(.closeWhite?.resize(size: .init(width: 16, height: 16)), for: .normal)
        button.layer.masksToBounds = true
        var config = UIButton.Configuration.filled()
        button.configuration = config
        button.configurationUpdateHandler = { btn in
            btn.configuration?.baseBackgroundColor = UIColor.component(0, 0, 0, 0.6)
            btn.alpha = btn.state != .highlighted ? 1 : 0.6
        }
        return button
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    private func configure() {
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        self.contentView.addSubview(container)
        
        container.flex
            .addItem(imageView)
            .position(.absolute)
            .horizontally(0)
            .vertically(0)
        container
            .flex
            .addItem()
            .define { flex in
                flex.addItem(deleteButton)
                    .size(.init(width: 24, height: 24))
                    .margin(8)
            }
            .alignItems(Locale.direction == .leftToRight ? .end : .start)
    }
    
    public func fill(photo: FileInfo) {
        imageView.image = UIImage(data: photo.data)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.all()
        container.flex.layout()
        
        deleteButton.layer.cornerRadius = deleteButton.frame.width / 2
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
