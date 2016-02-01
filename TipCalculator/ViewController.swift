//
//  ViewController.swift
//  TipCalculator
//
//  Created by Kirill Suslov on 2016-01-25.
//  Copyright © 2016 Kirill Suslov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Views
    @IBOutlet weak var billAmont: UITextField!
    @IBOutlet weak var tipPercentage: UILabel!
    @IBOutlet weak var tip: UILabel!
    @IBOutlet weak var total: UILabel!
    
    // Simple model
    var percent:Double {
        get{
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .PercentStyle
            return formatter.numberFromString(tipPercentage.text!)!.doubleValue
        }
        set {
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .PercentStyle
            tipPercentage.text = formatter.stringFromNumber(newValue)
        }
    }
    
    var bill:Double {
        get{
            return NSNumberFormatter().numberFromString(billAmont.text!)?.doubleValue ?? 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    // plus button
    @IBAction func increasePercent(sender: UIButton) {
        billAmont.resignFirstResponder()
        percent += 0.01
        calculateTotalAndTip()
    }
    
    // minus button
    @IBAction func decreasePercent(sender: UIButton) {
        billAmont.resignFirstResponder()
        if(percent > 0){
            percent -= 0.01
            calculateTotalAndTip()
        }
    }
    
    @IBAction func billChanging(sender: UITextField) {
        calculateTotalAndTip()
    }
    
    func calculateTotalAndTip(){
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        tip.text = formatter.stringFromNumber(bill * percent)
        total.text = formatter.stringFromNumber(bill * (1 + percent))
    }
}

