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
        label.text = "残り\(currentSeconds)秒"
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true,
            block: update)
 //           userInfo: nil)
//        Timer.scheduledTimer(withTimeInterval: <#T##TimeInterval#>, repeats: <#T##Bool#>, block: <#T##(Timer) -> Void#>)
    }
    
    func update(timer: Timer)->Void {
        currentSeconds -= 1
        label.text = "残り\(currentSeconds)秒"
        if (currentSeconds == 0) {
            timer.invalidate()
            let soundId : SystemSoundID = 1005
            AudioServicesPlayAlertSound(soundId)
        }
    }
}

