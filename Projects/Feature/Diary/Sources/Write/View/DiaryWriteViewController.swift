//
//  DiaryWriteViewController.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUI
import RxSwift
import RxCocoa
import FeatureDiaryInterfaces

public final class DiaryWriteViewController<VM: DiaryWriteViewModel>: DailogViewController<VM>, UICollectionViewDelegateFlowLayout {
    
    private let headerView = DiaryWriteHeaderView(frame: .zero)
    private let footerView = DiaryWriteFooterView(frame: .zero)
    
    private let textView = TextView(frame: .zero)
    
    private let photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.register(DiaryWritePhotoItemCell.self, forCellWithReuseIdentifier: DiaryWritePhotoItemCell.identifier)
        view.showsHorizontalScrollIndicator = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func configure() {
        self.navigationBar = DiaryWriteNavigationBar.init(items: [], title: "")
        super.configure()
        
        photoCollectionView.delegate = self
        
        container.flex
            .addItem()
            .grow(1)
            .define { flex in
                flex.addItem(headerView)
                flex.addItem(photoCollectionView)
                    .height(150)
                    .marginHorizontal(12)
                
                flex.addItem(textView)
                    .grow(1)
                flex.addItem(footerView)
            }
    }
    
    public override func bind() {
        super.bind()
        
        let photoDeleteButtonTapped: PublishRelay<String> = .init()
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .subscribe { [weak self] notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    self?.footerView.flex
                        .marginBottom(keyboardFrame.height - (self?.view.safeAreaInsets.bottom ?? 0))
                    
                    self?.footerView.flex.markDirty()
                    self?.container.flex.layout()
                }
                
            }
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .subscribe { [weak self] notification in
                self?.footerView.flex
                    .marginBottom(0)
                
                self?.footerView.flex.markDirty()
                self?.container.flex.layout()
            }
            .disposed(by: disposeBag)
        
        let output = viewModel.transform(
            input: .init(
                backButtonTapped: navigationBar?.rx.tap.filter { $0 == .back }.map { _ in }.asObservable(),
                emotionButtonTapped: headerView.emotionButton.rx.tap.asObservable(),
                addPhotoButtonTapped: footerView.showGalleryButton.rx.tap.asObservable(),
                captureCameraButtonTapped: footerView.showCameraButton.rx.tap.asObservable(),
                photoDeleteButtonTapped: photoDeleteButtonTapped.asObservable(),
                saveButtonTapped: navigationBar?.rx.tap.filter { $0 == .confirm }.map { _ in }.asObservable()
            )
        )
        
        output.emotion
            .distinctUntilChanged()
            .drive(headerView.rx.emotion)
            .disposed(by: disposeBag)
        
        output.photos
            .map { !$0.isEmpty }
            .drive { [weak self] isEmpty in
                guard let self else { return }
                photoCollectionView.flex.isIncludedInLayout(isEmpty)
                container.flex.layout()
            }
            .disposed(by: disposeBag)
        
        output.photos
            .drive(photoCollectionView.rx.items) { view, row, item in
                let cell = view.dequeueReusableCell(withReuseIdentifier: DiaryWritePhotoItemCell.identifier, for: .init(row: row, section: 0))
                guard let cell = cell as? DiaryWritePhotoItemCell else { return cell }
                cell.fill(photo: item)
                cell.deleteButton.rx.tap.map { item.fileName }.bind(to: photoDeleteButtonTapped).disposed(by: cell.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width/3 - 10
        photoCollectionView.flex.height(size)
        photoCollectionView.flex.markDirty()
        container.flex.layout()
        
        return .init(width: size, height: size)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
