//
//  DiaryDetailViewController.swift
//  FeatureDiary
//
//  Created by 박승호 on 4/2/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SharedUI
import FeatureDiaryInterfaces

public final class DiaryDetailViewController<VM: DiaryDetailViewModel>: DailogViewController<VM> {
    private let titleLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.numberOfLines = 1
        label.text = "DAILOG"
        label.font = .serif(sizeOf: 20, weight: .medium).italic
        label.textColor = .navigationTitle
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .cursive(sizeOf: 16, weight: .medium)
        label.textColor = .title
        label.textAlignment = .right
        return label
    }()
    
    private let emotionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .cursive(sizeOf: 16, weight: .medium)
        label.textColor = .title
        return label
    }()
    
    private let contentsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .cursive(sizeOf: 20, weight: .medium)
        label.textColor = .title
        return label
    }()
    
    public override func configure() {
        navigationBar = DiaryNavigationBar(title: "DAILOG")
        super.configure()
        
        container
            .flex
            .addItem()
            .direction(.row)
            .define { flex in
                flex.addItem(emotionLabel)
                flex.addItem(dateLabel).grow(1)
            }
            .alignItems(.end)
            .marginHorizontal(12)
        
        container
            .flex
            .addItem(contentsLabel)
            .marginVertical(20)
            .marginHorizontal(20)
    }
    
    public override func bind() {
        super.bind()
        
        let output = viewModel.transform(
            input: .init(
                backButtonTapped: navigationBar?.rx.tap.filter { $0 == .back }.map { _ in }.asObservable(),
                moreButtonTapped: navigationBar?.rx.tap.filter { $0 == .more }.map { _ in }.asObservable()
            )
        )
        
        output.diary
            .map { "\($0.date.formattedString())" }
            .drive(dateLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.diary
            .map { $0.emotion == nil }
            .drive { [weak self] isEmpty in
                self?.emotionLabel.flex.isIncludedInLayout(!isEmpty)
                self?.emotionLabel.flex.markDirty()
                self?.container.flex.layout()
            }
            .disposed(by: disposeBag)
        
        output.diary
            .compactMap { $0.emotion }
            .map { "\($0.emoji) \($0.string)" }
            .drive(emotionLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.diary
            .map { $0.contents }
            .drive(contentsLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
