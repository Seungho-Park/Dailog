//
//  ReminderViewController.swift
//  FeatureReminder
//
//  Created by 박승호 on 3/30/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUI
import FeatureReminderInterfaces
import RxSwift
import RxCocoa
import FlexLayout
import DomainDiaryInterfaces

public final class ReminderViewController<VM: ReminderViewModel>: DailogViewController<VM> {
    private let scrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private let contentsView: UIView = UIView()
    
    private let dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = .cursive(sizeOf: 22, weight: .medium)
        label.textColor = .title
        label.textAlignment = .center
        return label
    }()
    
    private let leftArrowButton: UIButton = {
        let btn = UIButton(frame: .zero)
        var config = UIButton.Configuration.plain()
        config.contentInsets = .zero
        config.image = UIImage.back?.resize(size: .init(width: 24, height: 24))
        btn.configuration = config
        
        btn.configurationUpdateHandler = { btn in
            btn.alpha = btn.state != .highlighted ? 1 : 0.6
        }
        return btn
    }()
    
    private let rightArrowButton: UIButton = {
        let btn = UIButton(frame: .zero)
        var config = UIButton.Configuration.plain()
        config.contentInsets = .zero
        config.image = UIImage.forward?.resize(size: .init(width: 24, height: 24))
        btn.configuration = config
        btn.configurationUpdateHandler = { btn in
            btn.alpha = btn.state != .highlighted ? 1 : 0.6
        }
        return btn
    }()
    
    private let diariesCountLabel: UILabel = {
        let label = UILabel()
        label.font = .cursive(sizeOf: 20, weight: .bold)
        label.textColor = .title
        label.numberOfLines = 1
        label.text = "554"
        label.textAlignment = .center
        return label
    }()
    
    private let topEmotionLabel: UILabel = {
        let label = UILabel()
        label.font = .cursive(sizeOf: 20, weight: .bold)
        label.textColor = .title
        label.numberOfLines = 1
        label.text = "😃"
        label.textAlignment = .center
        return label
    }()
    
    private let emotionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Happy".localized
        label.font = .cursive(sizeOf: 12, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textColor = UIColor.title
        label.textAlignment = .center
        return label
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.font = .cursive(sizeOf: 20, weight: .bold)
        label.textColor = .title
        label.numberOfLines = 1
        label.text = "33,555,333"
        label.textAlignment = .center
        return label
    }()
    
    private let chartView = EmotionChartView(frame: .zero)
    private let timeGraphView = TimeGraphView(frame: .zero)
    
    public override func configure() {
        super.configure()
        
        scrollView.addSubview(contentsView)
        
        container.flex
            .addItem(scrollView)
            .width(100%)
            .height(100%)
        
        contentsView
            .flex
            .addItem()
            .direction(.row)
            .justifyContent(.center)
            .alignItems(.center)
            .define { flex in
                flex.addItem(leftArrowButton)
                flex.addItem(dateLabel).width(150)
                flex.addItem(rightArrowButton)
            }
            .height(50)
        
        contentsView
            .flex
            .addItem()
            .direction(.row)
            .border(1, .title)
            .cornerRadius(8)
            .marginHorizontal(20)
            .marginTop(15)
            .alignItems(.center)
            .height(100)
            .define { flex in
                flex.addItem()
                    .grow(1)
                    .basis(0)
                    .define { flex in
                        flex.addItem(makeTitleLabel("Diary Count".localized))
                        flex.addItem()
                            .grow(1)
                            .marginTop(12)
                            .define { flex in
                                flex.addItem(diariesCountLabel)
                                flex.addItem(makeTitleLabel("Items".localized, 12))
                                    .marginTop(5)
                            }
                            .justifyContent(.center)
                    }
                    .height(100%)
                    .paddingVertical(20)
                
                flex.addItem().width(1).height(70%).backgroundColor(.title)
                
                flex.addItem()
                    .grow(1)
                    .basis(0)
                    .define { flex in
                        flex.addItem(makeTitleLabel("Top Emotion".localized))
                        flex.addItem()
                            .grow(1)
                            .marginTop(12)
                            .define { flex in
                                flex.addItem(topEmotionLabel)
                                flex.addItem(emotionDescriptionLabel)
                                    .marginTop(5)
                            }
                            .justifyContent(.center)
                    }
                    .height(100%)
                    .paddingVertical(20)
                
                flex.addItem().width(1).height(70%).backgroundColor(.title)
                
                flex.addItem()
                    .grow(1)
                    .basis(0)
                    .define { flex in
                        flex.addItem(makeTitleLabel("Character Count".localized))
                        flex.addItem()
                            .grow(1)
                            .marginTop(12)
                            .define { flex in
                                flex.addItem(characterCountLabel)
                                flex.addItem(makeTitleLabel("Characters", 12))
                                    .marginTop(5)
                            }
                            .justifyContent(.center)
                    }
                    .height(100%)
                    .paddingVertical(20)
            }
        
        contentsView
            .flex
            .addItem(chartView)
            .marginTop(30)
            .marginBottom(30)
        
        contentsView
            .flex
            .addItem(timeGraphView)
            .marginBottom(30)
    }
    
    public override func bind() {
        super.bind()
        let output = viewModel.transform(
            input: .init(
                viewWillAppear: rx.viewWillAppear.map { _ in }.asObservable(),
                prevDateButtonTapped: Locale.direction == .leftToRight ? leftArrowButton.rx.tap.asObservable() : rightArrowButton.rx.tap.asObservable(),
                nextDateButtonTapped: Locale.direction == .leftToRight ? rightArrowButton.rx.tap.asObservable() : leftArrowButton.rx.tap.asObservable()
            )
        )
        
        output.date
            .drive { [weak self] dateString in
                self?.dateLabel.text = dateString
                self?.dateLabel.flex.markDirty()
                self?.container.flex.layout()
            }
            .disposed(by: disposeBag)
        
        output.diaries
            .map { String($0.count) }
            .drive(diariesCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.diaries
            .map { $0.map { $0.contents.count } }
            .drive { [weak self] values in
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                self?.characterCountLabel.text = formatter.string(for: values.reduce(0, +))
            }
            .disposed(by: disposeBag)
        
        output.diaries
            .map { diaries in
                var times: [String:Int] = [:]
                let calendar = Calendar.current
                
                for diary in diaries {
                    let hour = calendar.component(.hour, from: diary.date)
                    
                    switch hour {
                    case 5..<9:
                        times["Morning", default: 0] += 1
                    case 9..<18:
                        times["Afternoon", default: 0] += 1
                    case 18..<21:
                        times["Evening", default: 0] += 1
                    case 21..<24:
                        times["Night", default: 0] += 1
                    default:
                        times["LateNight", default: 0] += 1
                    }
                }
                
                return times
            }
            .drive { [weak self] times in
                self?.timeGraphView.fill(data: times)
                self?.timeGraphView.flex.markDirty()
                self?.contentsView.flex.layout(mode: .adjustHeight)
                self?.scrollView.contentSize = self?.contentsView.frame.size ?? .zero
            }
            .disposed(by: disposeBag)
        
        output.emotions.filter { $0.isEmpty }
            .drive { [weak self] _ in
                self?.emotionDescriptionLabel.text = "-"
                self?.topEmotionLabel.text = "🫥"
            }
            .disposed(by: disposeBag)
        
        output.emotions
            .filter { $0.count > 0 }
            .compactMap {
                $0.sorted { lhs, rhs in
                    lhs.value > rhs.value
                }.first?.key
            }
            .drive { [weak self] emotion in
                self?.emotionDescriptionLabel.text = emotion.string
                self?.topEmotionLabel.text = emotion.emoji
            }
            .disposed(by: disposeBag)
        
        output.emotions
            .drive { [weak self] emotions in
                self?.chartView.fill(emotions: emotions)
                self?.chartView.flex.markDirty()
                self?.contentsView.flex.layout(mode: .adjustHeight)
                self?.scrollView.contentSize = self?.contentsView.frame.size ?? .zero
            }
            .disposed(by: disposeBag)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        contentsView.pin.all()
        contentsView.flex.layout(mode: .adjustHeight)
        scrollView.contentSize = contentsView.frame.size
    }
}

private extension ReminderViewController {
    func makeTitleLabel(_ text: String, _ size: CGFloat = 14)-> UILabel {
        let label = UILabel(frame: .zero)
        label.text = text
        label.font = .cursive(sizeOf: size, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textColor = UIColor.title
        label.textAlignment = .center
        return label
    }
}
