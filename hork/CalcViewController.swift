//
//  calcViewController.swift
//  hork
//
//  Created by Karan Gupta on 5/20/18.
//  Copyright © 2018 Karan Gupta. All rights reserved.
//

import UIKit
        //USE OLD REFERENCE
class CalcViewController: UIViewController {
        //initiate value for initial use
    var brain = CalcAlgo()
    var userIsCurrentlyTyping = false
    var hasDecimal = false
        //when a number is pressed
    @IBOutlet weak var display: UILabel!
    @IBAction func numberPressed(_ sender: UIButton) {
        let buttonText = sender.currentTitle!
        
        if userIsCurrentlyTyping {
            let currentText = display.text!
            display.text = currentText + buttonText
        } else {
            display.text = buttonText
            userIsCurrentlyTyping = true
            hasDecimal = false
        }
    }
        //display a value when button is pressed
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
        //when a value is already on the display
    @IBAction func operationPressed(_ sender: UIButton) {
        userIsCurrentlyTyping = false
        brain.setOperand(displayValue)
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
            hasDecimal = false
        }
        if let result = brain.result {
            displayValue = result
        }
    }
        //clear buttton
    @IBAction func clear(_ sender: UIButton) {
        display.text = "0"
        brain.reset()
        hasDecimal = false
    }
        //decimal button
    @IBAction func decimal(_ sender: UIButton) {
        if !hasDecimal{
            let currentText = display.text!
            if userIsCurrentlyTyping {
                display.text = currentText + "."
            }else{
                display.text = "0."
                userIsCurrentlyTyping = true
                hasDecimal = true
            }
        }
    }
}

