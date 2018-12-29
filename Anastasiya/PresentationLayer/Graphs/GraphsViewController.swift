//
//  GraphsViewController.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 22/12/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import UIKit
import Charts
import MessageUI

class GraphsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var firstLineChart: LineChartView!
    @IBOutlet weak var secondLineChart: LineChartView!
    @IBOutlet weak var saveButton: UIButtonX!
    
    var parameters: ParametersProfile?
    var saveIsHiden: Bool = false
    
    private var parametersStorageModel = AppDelegate.rootAssembly.presentationAssembly.parametsersStorageModel
    override func viewDidLoad() {
        super.viewDidLoad()
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1] as URL)
        // First Chart Lines
        self.setChartDesign(lineChart: self.firstLineChart)
        //
        // Second Chart Lines
        self.setChartDesign(lineChart: self.secondLineChart)
        //
        setDataCountFirstChart()
        setDataCountSecondChart()
        self.saveButton.isHidden = saveIsHiden

    }
    
    private func setChartDesign(lineChart: LineChartView) {
        lineChart.xAxis.gridLineDashLengths = [10, 10]
        lineChart.xAxis.labelTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let firstChartLeftAxis = lineChart.leftAxis
        firstChartLeftAxis.gridLineDashLengths = [5, 5]
        firstChartLeftAxis.labelTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func setDataCountFirstChart(_ count: Int = 20) {
        guard let parameter = self.parameters else { return }
        let sigmaCritOne = ((parameter.sigmaTwo * parameter.taoTwo) - (parameter.sigmaOne * parameter.taoOne)) / (parameter.taoTwo - parameter.taoOne)
        
        let values = (0..<count).map { (i) -> ChartDataEntry in
            let val = (parameter.sigmaOne - sigmaCritOne) * Double(i)
            return ChartDataEntry(x: Double(i), y: val)
        }
        //Castomize chart
        let set1 = setDataSet(values: values, label: "Data set1")
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
        let set1 = setDataSet(values: values, label: "Data set2")
        let data1 = LineChartData(dataSet: set1)
        self.secondLineChart.legend.form = .line
        self.secondLineChart.rightAxis.enabled = false
        self.secondLineChart.data = data1
        DispatchQueue.main.async {
        self.secondLineChart.animate(xAxisDuration: 1)
        }
    }
    
    private func setDataSet(values: [ChartDataEntry], label: String) -> LineChartDataSet {
        let set = LineChartDataSet(values: values, label: label)
        set.setColor(#colorLiteral(red: 0.8941176471, green: 0.3529411765, blue: 0.431372549, alpha: 1))
        set.setCircleColor(#colorLiteral(red: 0.7905326217, green: 0.311452509, blue: 0.3857892954, alpha: 1))
        set.lineWidth = 1
        set.circleRadius = 1
        set.valueFont = .systemFont(ofSize: 10)
        set.valueColors = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set.fillAlpha = 1
        set.fill = Fill(linearGradient: gradient, angle: 90)
        set.drawFilledEnabled = true
        return set
    }
    
    
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showMailError()
        }
    }
    
    private func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        firstLineChart.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7034995719)
        if let firstImage = firstLineChart.getChartImage(transparent: true)!.pngData() {
            mailComposerVC.addAttachmentData(firstImage, mimeType: "image/png", fileName: "First")
        }
        secondLineChart.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7034995719)
        if let secondImage = secondLineChart.getChartImage(transparent: true)!.pngData() {
            mailComposerVC.addAttachmentData(secondImage, mimeType: "image/png", fileName: "Second")
        }
        
        mailComposerVC.setToRecipients(["belbog@me.com"])
        mailComposerVC.setSubject("Hello")
        mailComposerVC.setMessageBody("How are you doing?", isHTML: false)
        firstLineChart.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        secondLineChart.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        return mailComposerVC
    }
    
    private func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveDataPresed(_ sender: Any) {
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Enter the name", message: nil, preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            guard let alert = alert else {return}
            guard let alertTextFields = alert.textFields else { return }
            if alertTextFields[0].text != "" {
                self.parameters?.name = alertTextFields[0].text
                self.parameters?.date = Date()
                self.parametersStorageModel.saveUser(parameters: self.parameters!, completion: { (success) in
                     if success {
                        self.successAlert()
                     } else {
                        self.errorAlert(function: { self.saveDataPresed(sender) })
                    }
                })
            } else {
                self.errorAlert()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    private func successAlert() {
        let alertController = UIAlertController(title: "Changes saved!", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func errorAlert(function: @escaping () -> Void) {
        let alertController = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
        let repeatAction = UIAlertAction(title: "Save again", style: .default, handler: {
            (_: UIAlertAction!) in function()
        })
        
        alertController.addAction(repeatAction)
        alertController.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func errorAlert() {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Missing name", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
}
