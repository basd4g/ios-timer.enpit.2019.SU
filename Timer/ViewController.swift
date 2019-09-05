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
        if sender.currentTitle! == "start" {
            isMovingTimer = true
            start(seconds: timerStartSeconds)
            sender.setTitle("stop", for: .normal)
        } else {
            isMovingTimer = false
            sender.setTitle("start", for: .normal)
            timerStartSeconds = currentSeconds
        }
        printLabel()
    }
    func start(seconds: Int) {
        if(seconds>0){
            currentSeconds =  seconds
        } else{
            currentSeconds = 1
        }
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true,
            block: update)
    }
    
    func update(timer: Timer)->Void {
        currentSeconds -= 1
        printLabel()
        if (currentSeconds == 0) {
            timer.invalidate()
//            AudioServicesPlayAlertSound(soundId)
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
        if isMovingTimer {
            let hour = currentSeconds / 3600
            let min = (currentSeconds % 3600) / 60
            let sec = currentSeconds % 60
            label.text = "残り\(hour)時間\(min)分\(sec)秒"
        } else {
            if (inputedNumber == 0) {
                let hour = timerStartSeconds / 3600
                let min = (timerStartSeconds % 3600) / 60
                let sec = timerStartSeconds % 60
                label.text = "\(hour)時間\(min)分\(sec)秒"
            } else {
                label.text = "\(inputedNumber)"
            }
        }
    }
}

