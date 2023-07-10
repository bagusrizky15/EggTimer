//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes = ["Soft" : 3, "Medium" : 5 , "Hard": 7]
    var secondRemaining = 60
    var timer = Timer()
    var player : AVAudioPlayer?
    var secondPassed = 0
    var totalTime = 0
    
    
    @IBOutlet weak var progressBar: UIProgressView!
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
        progressBar.progress = 0
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        secondRemaining=eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc
    func updateCounter(){
        if secondPassed < totalTime {
        secondPassed += 1
            progressBar.setProgress(Float(secondPassed) / Float(totalTime), animated: true)
        }
    }
    
    @objc
    func updateTimer(){
        if secondRemaining > 0 {
            print("\(secondRemaining) seconds.")
            secondRemaining -= 1
            titleLabel.text = "\(secondRemaining)"
        } else {
            timer.invalidate()
            playSound()
            titleLabel.text = "DONE"
        }
    }
    
    func playSound(){
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)

                /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                /* iOS 10 and earlier require the following line:
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

                guard let player = player else { return }

                player.play()

            } catch let error {
                print(error.localizedDescription)
            }
    }
    
}
