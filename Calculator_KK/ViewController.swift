//
//  ViewController.swift
//  Calculator_KK
//
//  Created by ＵＳＥＲ on 2019/9/6.
//  Copyright © 2019 hsin_project. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var numberOne: UIButton!
    @IBOutlet weak var numberTwo: UIButton!
    @IBOutlet weak var numberThree: UIButton!
    @IBOutlet weak var numberFour: UIButton!
    @IBOutlet weak var numberFive: UIButton!
    @IBOutlet weak var numberSix: UIButton!
    @IBOutlet weak var numberSeven: UIButton!
    @IBOutlet weak var numberEight: UIButton!
    @IBOutlet weak var numberNine: UIButton!
    @IBOutlet weak var numberZero: UIButton!
    @IBOutlet weak var decimalPoint: UIButton!
    
    
    @IBOutlet weak var addingBtn: UIButton!
    @IBOutlet weak var subtractingBtn: UIButton!
    @IBOutlet weak var multiplyingBtn: UIButton!
    @IBOutlet weak var dividingBtn: UIButton!
    @IBOutlet weak var outputBtn: UIButton!
    
    
    @IBOutlet weak var memoryCleanBtn: UIButton!
    @IBOutlet weak var memoryRecallBtn: UIButton!
    @IBOutlet weak var memoryPlusBtn: UIButton!
    @IBOutlet weak var memorySubtractBtn: UIButton!
    
    var numberArray:[NSObject] = []
    var latestNumberString: String = "0"
    var lastNumberString: String?
    var methold:CalculatorMethod = .None
    var memoryNumberString: String?
    
    enum CalculatorMethod {
        case None
        case Add
        case Subtract
        case Multiply
        case Divide
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayLabel.text = "0"
        
    }
    
    // MARK: Number Action
    
    @IBAction func typeNumberAction(_ sender: UIButton) {
      
        self.numberArray.append(NSNumber(value: sender.tag))
        latestNumberString = self.arrayToString(inputArray: self.numberArray)
        self.displayLabel.text = latestNumberString
    }
    
    @IBAction func appendDecimalPoint(_ sender: Any) {
       
        if self.numberArray.contains("." as NSObject) {
            return
        } else {
            self.numberArray.append("." as NSObject)
        }
    }
    
    @IBAction func numberByAdding(_ sender: Any) {
        
        lastNumberString = latestNumberString
        methold = .Add
        self.numberArray.removeAll()
    }
    
    
    @IBAction func numberBySubtracting(_ sender: Any) {
        lastNumberString = latestNumberString
        methold = .Subtract
        self.numberArray.removeAll()
    }
    
    
    @IBAction func numberByMultiplying(_ sender: Any) {
        lastNumberString = latestNumberString
        methold = .Multiply
        self.numberArray.removeAll()
    }
    
    
    @IBAction func numberByDividing(_ sender: Any) {
        lastNumberString = latestNumberString
        methold = .Divide
        self.numberArray.removeAll()
    }
    
    
    @IBAction func memoryCleaning(_ sender: Any) {
        memoryNumberString = nil

    }
    
    
    
    @IBAction func memoryAdding(_ sender: Any) {
        self.numberArray.removeAll()
        if memoryNumberString != nil {
            let result: Double = self.addingAction(originalNumber: self.stringToDouble(inputString: latestNumberString), addingNumber: self.stringToDouble(inputString: memoryNumberString!))
            latestNumberString = self.doubleToString(inpuDouble: result)
            self.displayLabel.text = result.removeZerosFromEnd()
        } else {
            memoryNumberString = latestNumberString
        }
    }
    
    @IBAction func memorySubtracting(_ sender: Any) {
        self.numberArray.removeAll()
        if memoryNumberString != nil {
            let result: Double = self.subtractingAction(originalNumber: self.stringToDouble(inputString: latestNumberString), subtractingNumber: self.stringToDouble(inputString: memoryNumberString!))
            latestNumberString = self.doubleToString(inpuDouble: result)
            self.displayLabel.text = result.removeZerosFromEnd()
        } else {
            memoryNumberString = latestNumberString
        }
    }
    
    @IBAction func memoryRecall(_ sender: Any) {
        self.numberArray.removeAll()
        if memoryNumberString != nil {
            let result = self.stringToDouble(inputString: memoryNumberString!)
            self.displayLabel.text = String(result.removeZerosFromEnd())
        } else {
             self.displayLabel.text = "0"
        }
    }
    
    @IBAction func memorySubstitute(_ sender: Any) {
       memoryNumberString = self.displayLabel.text
    }
    
    
    @IBAction func clearAction(_ sender: Any) {
        self.numberArray.removeAll()
        lastNumberString = "0"
        self.displayLabel.text = "0"
    }
    
    
    
    @IBAction func numberOutput(_ sender: Any) {
        switch methold {
        case .Add :
            let result: Double = self.addingAction(originalNumber: self.stringToDouble(inputString: lastNumberString!), addingNumber: self.stringToDouble(inputString: latestNumberString))
            latestNumberString = self.doubleToString(inpuDouble: result)
            self.displayLabel.text = result.removeZerosFromEnd()
            
        case .Subtract :
            let result: Double = self.subtractingAction(originalNumber: self.stringToDouble(inputString: lastNumberString!), subtractingNumber: self.stringToDouble(inputString: latestNumberString))
            latestNumberString = self.doubleToString(inpuDouble: result)
            self.displayLabel.text = result.removeZerosFromEnd()
        case .Multiply :
            let result: Double = self.multiplyingByAction(originalNumber: self.stringToDouble(inputString: lastNumberString!), multiplyingByNumber: self.stringToDouble(inputString: latestNumberString))
            latestNumberString = self.doubleToString(inpuDouble: result)
            self.displayLabel.text = result.removeZerosFromEnd()
            
        case .Divide :
            let result: Double = self.dividingByAction(originalNumber: self.stringToDouble(inputString: lastNumberString!), dividingByNumber: self.stringToDouble(inputString: latestNumberString))
            latestNumberString = self.doubleToString(inpuDouble: result)
            self.displayLabel.text = result.removeZerosFromEnd()
            
        default:
            break
        }
        
    }
    
    
    
    // MARK: Number Tool
    
    func arrayToString(inputArray: Array<Any>) -> String {

        var numberString: String = ""
        _ = inputArray.map{ numberString = numberString + "\($0)" }
        return numberString
    }

    
    func stringToDouble(inputString:String) -> Double {
        guard let numberDouble = Double(inputString) else { return 0 }
        return numberDouble
    }
    
    func doubleToString(inpuDouble:Double) -> String {
        let numberString = String(format: "%f", inpuDouble)
        
        return numberString
    }
    
    
     // MARK: Calculation Action
    
    func addingAction(originalNumber: Double, addingNumber: Double) -> Double {
        return originalNumber + addingNumber
    }
    
    func subtractingAction(originalNumber: Double, subtractingNumber: Double) -> Double {
        return originalNumber - subtractingNumber
    }
    
    func multiplyingByAction(originalNumber: Double, multiplyingByNumber: Double) -> Double {
        return originalNumber * multiplyingByNumber
    }
    
    func dividingByAction(originalNumber: Double, dividingByNumber: Double) -> Double {
        return originalNumber / dividingByNumber
    }
    
    
    
    
    
    
    
 
}


extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
