//
//  ViewController.swift
//  Calculator
//
//  Created by carlos calderon on 11/12/16.
//  Copyright © 2016 carlos calderon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var brain = CalculatorBrain()
    @IBOutlet private weak var display: UITextField!
    var userIsInTheMiddleOfTyping = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction private func touchDigit(sender: UIButton) {
   
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text
            display.text = textCurrentlyInDisplay! + digit

        } else {
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        
        displayValue = brain.result
        
    }
    
    var savedProgram: CalculatorBrain.PropertyList?
    
    @IBAction func save(sender: UIButton) {
   
        savedProgram = brain.program
        
    }
    
    @IBAction func restore(sender: UIButton) {
    
        if(savedProgram != nil) {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    

}

