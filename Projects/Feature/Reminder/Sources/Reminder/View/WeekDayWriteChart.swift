//
//  WeekDayWriteChart.swift
//  FeatureReminder
//
//  Created by 박승호 on 4/1/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUI
import DGCharts
import FlexLayout
import DomainDiaryInterfaces

public final class WeekDayWriteCharView: UIView {
    private let container = UIView()
    
    private let chartView: BarChartView = {
        let chart = BarChartView()
        chart.noDataText = "No Emotion Regit Comment".localized
        chart.noDataFont = .cursive(sizeOf: 20, weight: .medium)
        chart.noDataTextColor = .title
        chart.noDataTextAlignment = .center
        chart.rightAxis.enabled = false
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.labelFont = .cursive(sizeOf: 12, weight: .medium)
        chart.xAxis.granularity = 1
        chart.xAxis.drawGridLinesEnabled = false
        chart.leftAxis.granularity = 1
        chart.leftAxis.drawGridLinesEnabled = false
        chart.leftAxis.labelFont = .cursive(sizeOf: 12, weight: .medium)
        chart.legend.enabled = false
        chart.isUserInteractionEnabled = false
        return chart
    }()
    
    private let wrapChartView = UIView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    private func configure() {
        addSubview(container)
        
        container
            .flex
            .define { flex in
                let label = UILabel()
                label.text = "Emotion Chart".localized
                label.textColor = .title
                label.numberOfLines = 1
                label.font = .cursive(sizeOf: 22, weight: .bold)
                
                flex.addItem(label)
                    .marginHorizontal(12)
                
                flex.addItem(wrapChartView)
                    .marginTop(12)
                    .height(250)
                    .define { flex in
                        flex.addItem(chartView).grow(1)
                    }
                    .paddingHorizontal(20)
            }
            .justifyContent(.center)
            .grow(1)
    }
    
    public func fill(emotions: [Emotion:Int]) {
        guard emotions.count > 0 else {
            chartView.data = nil
            chartView.notifyDataSetChanged()
            
            wrapChartView.flex.height(100)
            chartView.flex.border(1, .title)
            chartView.flex.cornerRadius(8)
            return
        }
        
        let emotions = emotions.map { ($0.key, $0.value) }.sorted { lhs, rhs in
            lhs.1 > rhs.1
        }
        
        let entries = emotions.enumerated().map { (index, emotion) -> BarChartDataEntry in
            let entry = BarChartDataEntry(x: Double(index), y: Double(emotion.1))
            return entry
        }
        
        let dataSet = BarChartDataSet(entries: entries, label: "")
        dataSet.colors = emotions.map { _ in UIColor.softCoral }
        dataSet.valueTextColor = .black
        dataSet.valueFont = .cursive(sizeOf: 12, weight: .medium)
        
        let intFormatter = NumberFormatter()
        intFormatter.numberStyle = .none
        intFormatter.maximumFractionDigits = 0
        let formatter = DefaultValueFormatter(formatter: intFormatter)
        formatter.decimals = 0
        
        let chartData = BarChartData(dataSet: dataSet)
        chartData.barWidth = 0.5
        chartView.data = chartData
        
        dataSet.valueFormatter = formatter
        
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: emotions.map { $0.0.emoji })
        chartView.xAxis.setLabelCount(emotions.count, force: false)
        
        chartView.notifyDataSetChanged()
        
        wrapChartView.flex.height(250)
        chartView.flex.border(0, .clear)
        chartView.flex.cornerRadius(0)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.wrapContent()
        container.flex.layout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
