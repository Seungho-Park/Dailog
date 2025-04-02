//
//  TimeGraphView.swift
//  FeatureReminder
//
//  Created by 박승호 on 4/1/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUI
import DGCharts
import FlexLayout

public final class TimeGraphView: UIView {
    private let container = UIView()
    
    private let wrapChartView: UIView = UIView()
    
    private let chartView: PieChartView = {
        let chart = PieChartView()
        chart.noDataText = "No Emotion Regit Comment".localized
        chart.noDataFont = .cursive(sizeOf: 20, weight: .medium)
        chart.noDataTextColor = .title
        chart.noDataTextAlignment = .center
        chart.chartDescription.enabled = false
        chart.legend.enabled = false
        chart.holeRadiusPercent = 0.4
        chart.transparentCircleRadiusPercent = 0
        chart.holeColor = .clear
        chart.isUserInteractionEnabled = false
        return chart
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    private func configure() {
        addSubview(container)
        
        container.flex
            .addItem()
            .grow(1)
            .define { flex in
                let label = UILabel()
                label.text = "Writing Time Chart".localized
                label.textColor = .title
                label.numberOfLines = 1
                label.font = .cursive(sizeOf: 24, weight: .medium)
                
                flex.addItem(label)
                    .marginHorizontal(12)
                    .marginBottom(12)
                
                flex.addItem(wrapChartView)
                    .height(200)
                    .paddingHorizontal(20)
                    .define { flex in
                        flex.addItem(chartView)
                            .grow(1)
                    }
            }
    }
    
    public func fill(data: [String:Int]) {
        guard data.count > 0 else {
            chartView.data = nil
            chartView.notifyDataSetChanged()
            
            wrapChartView.flex.height(100)
            chartView.flex.border(1, .title)
            chartView.flex.cornerRadius(8)
            return
        }
        
        var entries: [PieChartDataEntry] = []
        let times = ["Morning", "Afternoon", "Evening", "Night", "LateNight"]
        for time in times {
            guard let count = data[time] else { continue }
            let entry = PieChartDataEntry(value: Double(count), label: time)
            entries.append(entry)
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        
        dataSet.colors = [
            UIColor.component(253, 230, 138), UIColor.component(125, 211, 252), UIColor.component(52, 211, 153), UIColor.component(107, 114, 128), UIColor.component(192, 132, 252)
        ]
        
        dataSet.yValuePosition = .outsideSlice
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueLineWidth = 1
        dataSet.valueLineColor = .title
        dataSet.valueLineVariableLength = true
        dataSet.valueLinePart1Length = 0.5
//        dataSet.valueLinePart2Length = 0.4
        
        let chartData = PieChartData(dataSet: dataSet)
        chartView.data = chartData
        chartData.setValueFont(.cursive(sizeOf: 16, weight: .medium))
        chartData.setValueTextColor(.title)
        
        let intFormatter = NumberFormatter()
        intFormatter.numberStyle = .none
        intFormatter.maximumFractionDigits = 0
        dataSet.valueFormatter = DefaultValueFormatter(formatter: intFormatter)
        
        chartView.notifyDataSetChanged()
        wrapChartView.flex.height(200)
        chartView.flex.border(0, .clear)
        chartView.flex.cornerRadius(0)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.wrapContent()
        container.flex.layout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
}
