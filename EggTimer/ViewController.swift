//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes = ["Soft" : 3, "Medium" : 5 , "Hard": 7]
    var secondRemaining = 60
    var timer = Timer()
    
    @IBOutlet weak var inputTimer: UITextField!
    
    @IBAction func buttonStart(_ sender: UIButton) {
    timer.invalidate()
    let fieldValue = Int(inputTimer.text ?? "0")
        if fieldValue == nil {
            var alert = UIAlertController(title: "Warning", message: "Input number!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            secondRemaining=fieldValue!
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    
    }

    
    @IBAction func hardnessSelecter(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        secondRemaining=eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc
    func updateTimer(){
        if secondRemaining > 0 {
            print("\(secondRemaining) seconds.")
            secondRemaining -= 1
            titleLabel.text = "\(secondRemaining)"
        } else {
            timer.invalidate()
            titleLabel.text = "DONE"
        }
    }
    
}
