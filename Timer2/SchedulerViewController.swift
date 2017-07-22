//
//  SchedulerViewController.swift
//  Timer2
//
//  Created by Alfred Wu on 7/21/17.
//  Copyright © 2017 Alfred Wu. All rights reserved.
//

import UIKit

class SchedulerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var efficiency: Double {
        let row = pickerView.selectedRow(inComponent: 0)
        return Double(row + 1) / 100
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(49, inComponent: 0, animated: true)
    }

    
    
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
        let tabVC = self.parent as! UITabBarController
        let navigationVC = tabVC.viewControllers?[0] as! UINavigationController
        let timerListVC = navigationVC.viewControllers[0] as! TimerListTableViewController
        let totalElapsed = timerListVC.totalElapsed
        let totalMax = timerListVC.totalMax

        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        
        var textViewString = "\(format(totalElapsed)) at \(dateFormatter.string(from: nowDate))\n"
        
        var i = (totalElapsed / 3600 + 1) * 3600
        while true {
            let date = Date() + TimeInterval(Double(i - totalElapsed) / efficiency)
            textViewString += "\(format(i)) at \(dateFormatter.string(from: date))\n"
            
            i += 3600
            if i > totalMax {
                break
            }
        }
        
        let finishDate = Date() + TimeInterval(Double(totalMax) / efficiency)
        textViewString += "\(format(totalMax)) at \(dateFormatter.string(from: finishDate))\n"

        textView.text = textViewString
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Picker Delegate/Data Source Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)%"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
