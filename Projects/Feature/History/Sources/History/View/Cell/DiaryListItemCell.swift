//
//  DiaryListItemCell.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/26/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout
import DomainDiaryInterfaces
import FeatureHistoryInterfaces

public final class DiaryListItemCell: UITableViewCell {
    public static let identifier = "DiaryListItemCell"
    
    private let container = UIView()
    
    private let emojiLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "😀"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 28)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = .cursive(sizeOf: 18, weight: .bold)
        label.textColor = .navigationTitle
        label.text = Date().formattedString()
        label.flex.markDirty()
        return label
    }()
    
    private let emotionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.textColor = .title
        label.font = .cursive(sizeOf: 16, weight: .medium)
        label.text = "Happy".localized
        label.flex.markDirty()
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let contentsLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.numberOfLines = 4
        label.font = .cursive(sizeOf: 18, weight: .medium)
        label.lineBreakMode = .byTruncatingTail
        label.text = "나는 한국인\n한국어를 사용하지\n하하.\n하하하하\n하하하"
        return label
    }()
    
    private let photoView = {
        UIView()
    }()
        
    private let photoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    private let hasMultiImagesView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "square.fill.on.square.fill")?.withTintColor(.component(255, 255, 255), renderingMode: .alwaysOriginal))
        view.contentMode = .scaleToFill
        view.transform = .init(rotationAngle: .pi)
        return view
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        contentView.clipsToBounds = true
        configure()
    }
    
    private func configure() {
        let wrapView = contentView
            .flex
            .addItem()
            .marginHorizontal(20)
            .marginTop(25)
        
        let contentView = UIView()
        
        contentView
            .flex
            .direction(.column)
            .grow(1)
        
        let dataView = UIView()
        
        dataView
            .flex
            .direction(.row)
            .alignItems(.center)
            .define { flex in
                let labels = UIView()
                
                labels.flex
                    .direction(.column)
                    .define { flex in
                        flex.addItem(dateLabel)
                            .marginBottom(0.5)
                        flex.addItem(emotionLabel)
                            .marginTop(0.5)
                    }
                    .grow(1)
                
                switch Locale.direction {
                case .leftToRight:
                    flex.addItem(emojiLabel).marginRight(5)
                    flex.addItem(labels).marginLeft(5)
                case .rightToLeft:
                    flex.addItem(labels).marginRight(5)
                    flex.addItem(emojiLabel).marginLeft(5)
                }
            }
            .marginBottom(5)
        
        photoView
            .flex
            .define({ flex in
                flex.addItem(photoImageView)
                
                let hasMultiple = flex.addItem(hasMultiImagesView)
                    .position(.absolute)
                    .top(5)
                    .width(16)
                    .aspectRatio(1)
                
                if Locale.direction == .leftToRight {
                    hasMultiple.right(5)
                } else {
                    hasMultiple.left(5)
                }
            })
            .width(60)
            .height(60)
            .shrink(0)
        
        contentView.flex.addItem(dataView)
        
        switch Locale.direction {
        case .leftToRight:
            contentView.flex
                .addItem()
                .direction(.row)
                .alignItems(.start)
                .define { flex in
                    flex.addItem(contentsLabel)
                        .marginTop(5)
                        .marginLeft(6)
                        .marginRight(10)
                        .grow(1)
                        .shrink(1)
                    
                    flex.addItem(photoView)
                }
        case .rightToLeft:
            contentView.flex
                .addItem()
                .direction(.row)
                .alignItems(.start)
                .define { flex in
                    flex.addItem(photoView)
                    
                    flex.addItem(contentsLabel)
                        .marginTop(5)
                        .marginLeft(10)
                        .marginRight(6)
                        .grow(1)
                        .shrink(1)
                }
        }
        
        wrapView
            .addItem(contentView)
        
        wrapView
            .addItem(separatorView)
            .height(0.5)
            .marginTop(24)
    }
    
    public func fill(viewModel: DiaryListItemViewModel) {
        let lines = viewModel.content.components(separatedBy: "\n")
        if lines.count <= 4 {
            contentsLabel.text = lines.joined(separator: "\n")
        } else {
            contentsLabel.text = lines[..<4].joined(separator: "\n") + "..."
        }
        
        dateLabel.text = viewModel.date.formattedString()
        emojiLabel.text = viewModel.emotion?.emoji ?? "🫥"
        emotionLabel.text = viewModel.emotion?.string ?? "Not Selected".localized
        
        photoView.flex.isIncludedInLayout = viewModel.thumbnail?.image != nil
        hasMultiImagesView.isHidden = !(viewModel.thumbnail?.hasMultiple == true)
        if let data = viewModel.thumbnail?.image {
            photoImageView.image = UIImage(data: data)
        } else {
            photoImageView.image = nil
        }
        
        photoView.flex.markDirty()
        dateLabel.flex.markDirty()
        contentsLabel.flex.markDirty()
        emotionLabel.flex.markDirty()
        emojiLabel.flex.markDirty()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        contentView.flex.layout(mode: .adjustHeight)
        
        return contentView.frame.size
    }
    
    required public init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
}
