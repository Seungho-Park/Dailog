//
//  EmotionViewController.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/18/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUI
import RxSwift
import RxCocoa
import FlexLayout
import PinLayout
import FeatureDiaryInterfaces
import DomainDiaryInterfaces

public final class EmotionViewController<VM: EmotionViewModel>: DailogViewController<VM>, UICollectionViewDelegateFlowLayout {
    private lazy var titleLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.font = .cursive(sizeOf: 20, weight: .bold)
        label.text = "Select Emotion Title".localized
        label.textColor = .textColor
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.font = .cursive(sizeOf: 16, weight: .medium)
        label.text = "Select Emotion Subtitle".localized
        label.textColor = .textColor
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.clipsToBounds = false
        view.register(EmotionListItemCell.self, forCellWithReuseIdentifier: EmotionListItemCell.identifier)
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(frame: .zero)
        var config = UIButton.Configuration.plain()
        button.configuration = config
        
        button.configurationUpdateHandler = { button in
            button.configuration?.attributedTitle = AttributedString(
                "Skip".localized,
                attributes: .init([
                    .foregroundColor : button.state != .highlighted ? UIColor.textColor : UIColor.textColor.withAlphaComponent(0.6),
                    .font: UIFont.cursive(sizeOf: 16, weight: .medium),
                    .underlineStyle : NSUnderlineStyle.single.rawValue,
                    .baselineOffset: 6
                ])
            )
        }
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func configure() {
        super.configure()
        
        container.flex
            .addItem()
            .define { flex in
                flex.addItem(titleLabel)
                    .marginBottom(5)
                flex.addItem(subtitleLabel)
                    .marginTop(5)
            }
            .marginHorizontal(12)
        
        container.flex.addItem(collectionView)
            .marginVertical(20)
            .marginHorizontal(20)
        
        container.flex
            .addItem()
            .alignItems(.center)
            .define { flex in
                flex.addItem(skipButton)
            }
            .marginTop(10)
            .marginHorizontal(12)
    }
    
    public override func bind() {
        super.bind()
        
        _ = viewModel.transform(
            input: .init(
                select: Observable<Emotion?>.merge(
                    skipButton.rx.tap.map { _-> Emotion? in nil }.asObservable(),
                    collectionView.rx.modelSelected(Emotion.self).map { emotion-> Emotion? in return emotion }.asObservable()
                )
            )
        )
        
        Observable.just(Emotion.allCases)
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items) { view, row, item in
                let cell = view.dequeueReusableCell(withReuseIdentifier: EmotionListItemCell.identifier, for: .init(row: row, section: 0))
                guard let cell = cell as? EmotionListItemCell else { return cell }
                cell.fill(emotion: item)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 2 - 10
        return .init(width: width, height: width  * 0.6)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.flex
            .height(collectionView.collectionViewLayout.collectionViewContentSize.height)
        
        collectionView.flex.markDirty()
        container.flex.layout()
    }
}
