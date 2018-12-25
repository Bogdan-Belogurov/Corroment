//
//  GraphsViewController.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 22/12/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import UIKit
import Charts

class GraphsViewController: UIViewController {
    
    
    @IBOutlet weak var firstLineChart: LineChartView!
    @IBOutlet weak var secondLineChart: LineChartView!
    var parameters: ParametersProfile?
    
    var iosDataEntry = PieChartDataEntry(value: 0)
    var macDataEntry = PieChartDataEntry(value: 0)
    
    var numberOfDownloadsDataEntries = [PieChartDataEntry]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // First Chart Lines
        firstLineChart.xAxis.gridLineDashLengths = [10, 10]
        firstLineChart.xAxis.labelTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let firstChartLeftAxis = firstLineChart.leftAxis
        firstChartLeftAxis.gridLineDashLengths = [5, 5]
        firstChartLeftAxis.labelTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        //
        // Second Chart Lines
        secondLineChart.xAxis.gridLineDashLengths = [10, 10]
        secondLineChart.xAxis.labelTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let secondChartleftAxis = secondLineChart.leftAxis
        secondChartleftAxis.gridLineDashLengths = [5, 5]
        secondChartleftAxis.labelTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        //
        setDataCountFirstChart()
        setDataCountSecondChart()

    }
    
    func setDataCountFirstChart(_ count: Int = 20) {
        guard let parameter = self.parameters else { return }
        let sigmaCritOne = ((parameter.sigmaTwo * parameter.taoTwo) - (parameter.sigmaOne * parameter.taoOne)) / (parameter.taoTwo - parameter.taoOne)
        
        let values = (0..<count).map { (i) -> ChartDataEntry in
            let val = (parameter.sigmaOne - sigmaCritOne) * Double(i)
            return ChartDataEntry(x: Double(i), y: val)
        }
        //Castomize chart
        let set1 = LineChartDataSet(values: values, label: "Data set 1")
        set1.setColor(#colorLiteral(red: 0.8941176471, green: 0.3529411765, blue: 0.431372549, alpha: 1))
        set1.setCircleColor(#colorLiteral(red: 0.7905326217, green: 0.311452509, blue: 0.3857892954, alpha: 1))
        set1.lineWidth = 1
        set1.circleRadius = 1
        set1.valueFont = .systemFont(ofSize: 10)
        set1.valueColors = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
        
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fillAlpha = 1
        set1.fill = Fill(linearGradient: gradient, angle: 90)
        set1.drawFilledEnabled = true
        
        let data1 = LineChartData(dataSet: set1)
        self.firstLineChart.legend.form = .line
        self.firstLineChart.rightAxis.enabled = false
        self.firstLineChart.data = data1
        DispatchQueue.main.async {
            self.firstLineChart.animate(xAxisDuration: 1)
        }
        
    }
    
    func setDataCountSecondChart(_ count: Int = 20) {
        guard let parameter = self.parameters else { return }
        let sigmaCritTwo = ((parameter.sigmaTwo * sqrt(parameter.taoTwo)) - (parameter.sigmaOne * sqrt(parameter.taoOne)) / (sqrt(parameter.taoTwo) - sqrt(parameter.taoOne)))
        
        let values = (1..<count).map { (i) -> ChartDataEntry in
            let val = (parameter.sigmaOne - sigmaCritTwo) * (1 / sqrt(Double(i)))
            return ChartDataEntry(x: Double(i), y: val)
        }
        //Castomize chart
        let set1 = LineChartDataSet(values: values, label: "Data set 2")
        set1.setColor(#colorLiteral(red: 0.8941176471, green: 0.3529411765, blue: 0.431372549, alpha: 1))
        set1.setCircleColor(#colorLiteral(red: 0.7905326217, green: 0.311452509, blue: 0.3857892954, alpha: 1))
        set1.lineWidth = 1
        set1.circleRadius = 1
        set1.valueFont = .systemFont(ofSize: 10)
        set1.valueColors = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
        
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fillAlpha = 1
        set1.fill = Fill(linearGradient: gradient, angle: 90)
        set1.drawFilledEnabled = true
        let data1 = LineChartData(dataSet: set1)
        self.secondLineChart.legend.form = .line
        self.secondLineChart.rightAxis.enabled = false
        
        
        self.secondLineChart.data = data1
        DispatchQueue.main.async {
            self.secondLineChart.animate(xAxisDuration: 1)
        }
    }
}
