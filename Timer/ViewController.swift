//
//  ViewController.swift
//  Timer
//
//  Created by 中山慶祐 on 2019/09/04.
//  Copyright © 2019 Keisuke Nakayama. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var timer: Timer?
    var currentSeconds = 0
    var isMovingTimer = false
    var inputedNumber: Int = 0
    var timerStartSeconds: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        printLabel()
    }
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        if isMovingTimer == true {
            return
        }
//        print("numberButtonTapped")
        let number = Int(sender.currentTitle!)!
//        print(number)
        inputedNumber = inputedNumber * 10 + number
//        print(inputedNumber)
        printLabel()
    }
    
    @IBAction func unitButtonTapped(_ sender: UIButton) {
        if isMovingTimer == true {
            return
        }
        print("unitButtonTapped")
        var hour = timerStartSeconds / 3600
        var min = (timerStartSeconds % 3600 ) / 60
        var sec = timerStartSeconds % 60
        switch sender.currentTitle! {
        case "Hour":
            hour = inputedNumber
        case "Min":
            min = inputedNumber
        case "Sec":
            sec = inputedNumber
        default :
            timerStartSeconds = 0
        }
        timerStartSeconds = (hour * 3600) + (min * 60) + sec
        inputedNumber = 0
        printLabel()
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        if isMovingTimer == true {
            return
        }
        inputedNumber = 0
        timerStartSeconds = 0
        printLabel()
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if inputedNumber != 0 {
            return
        }
        if !isMovingTimer {
            start(seconds: timerStartSeconds)
            sender.backgroundColor = UIColor(red:231/255,green:71/255,blue:59/255,alpha:1)
            sender.setTitle("stop", for: .normal)
        } else {
            sender.backgroundColor = UIColor(red:70/255,green:201/255,blue:60/255,alpha:1)
            sender.setTitle("start", for: .normal)
            timerStartSeconds = currentSeconds
        }
        isMovingTimer = !isMovingTimer
        printLabel()
    }
    func start(seconds: Int) {
        currentSeconds =  seconds
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true,
            block: update)
    }
    
    func update(timer: Timer)->Void {
        if currentSeconds > 0 {
            currentSeconds -= 1
        } else {
            currentSeconds = 0
        }
        printLabel()
        if (currentSeconds == 0) {
            timer.invalidate()
            repertTimerSounds()
        }
    }
    
    func repertTimerSounds() {
        if isMovingTimer {
            let soundId : SystemSoundID = 1005
            AudioServicesPlayAlertSoundWithCompletion(soundId) {
                self.repertTimerSounds()
            }
        }
    }
    
    func printLabel() {
        print("printLabel()")
        if !isMovingTimer && inputedNumber != 0 {
            label.text = "\(inputedNumber)"
            return
        }

        var labelText: String = ""
        var seconds: Int = 0
        
        if isMovingTimer {
            labelText += "残り"
            seconds = currentSeconds
        } else {
            seconds = timerStartSeconds
        }
        
        labelText += returnStringHHMMSS(
            hour: seconds / 3600,
            min: (seconds % 3600) / 60,
            sec: seconds % 60)
        
        label.text = labelText
    }
    
    func returnStringHHMMSS(hour: Int, min: Int, sec: Int) ->String {
        var returnString = ""
        returnString += String(format: "%02d", hour) + ":"
        returnString += String(format: "%02d", min) + ":"
        returnString += String(format: "%02d", sec)
        return returnString
    }
}

