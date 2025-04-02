//
//  WeekDayWriteCharView.swift
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
    private let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private let container = UIView()
    
    private lazy var chartView: LineChartView = {
        let chart = LineChartView()
        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: weekdays)
        chart.xAxis.granularity = 1
        chart.xAxis.labelPosition = .bottom
        chart.rightAxis.enabled = false
        chart.leftAxis.axisMinimum = 0
        chart.leftAxis.granularity = 1
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
                label.text = "Weekly Report".localized
                label.textColor = .title
                label.numberOfLines = 1
                label.font = .cursive(sizeOf: 24, weight: .medium)
                
                flex.addItem(label)
                    .marginHorizontal(12)
                
                flex.addItem(wrapChartView)
                    .marginTop(12)
                    .height(200)
                    .define { flex in
                        flex.addItem(chartView).grow(1)
                    }
                    .paddingHorizontal(20)
            }
            .justifyContent(.center)
            .grow(1)
    }
    
    public func fill(data: [String: Int]) {
        let sortedData = weekdays.compactMap { day -> ChartDataEntry? in
            if let count = data[day] {
                return ChartDataEntry(x: Double(weekdays.firstIndex(of: day) ?? 0), y: Double(count))
            }
            return nil
        }
        
        let dataSet = LineChartDataSet(entries: sortedData, label: "Writing")
        dataSet.circleRadius = 3
        dataSet.valueFont = .cursive(sizeOf: 14, weight: .medium)
        dataSet.drawCircleHoleEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.colors = [.softCoral]
        dataSet.circleColors = [.softCoral]
        dataSet.valueColors = [.title]
        
        let lineData = LineChartData(dataSet: dataSet)
        chartView.data = lineData
        
        let intFormatter = NumberFormatter()
        intFormatter.numberStyle = .none
        intFormatter.maximumFractionDigits = 0
        dataSet.valueFormatter = DefaultValueFormatter(formatter: intFormatter)
        
        chartView.notifyDataSetChanged()
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
