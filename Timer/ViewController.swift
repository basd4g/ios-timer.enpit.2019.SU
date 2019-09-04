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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tenSecButtonTapped(_ sender: Any) {
        start(seconds: 10)
    }
    @IBAction func threeMinButtonTapped(_ sender: Any) {
        start(seconds: 180)
    }
    @IBAction func fiveMinButtonTapped(_ sender: Any) {
        start(seconds: 300)
    }
    
    func start(seconds: Int) {
        currentSeconds = seconds
        printLabel()
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
            let soundId : SystemSoundID = 1005
            AudioServicesPlayAlertSound(soundId)
        }
    }
    
    func printLabel() {
        var seconds: Int = currentSeconds
        var secondsString: String = "残り"
        if(seconds > 3600) {
            secondsString += "\(seconds/3600)時間"
            seconds %= 3600
        }
        if(seconds > 60) {
            secondsString += "\(seconds/60)分"
            seconds %= 60
        }
        secondsString += "\(seconds)秒"
        label.text = secondsString
    }
}

