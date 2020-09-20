//
//   Do any additional setup after loading the view.swift
//  HeartAcuity
//
//  Created by Abishek on 19/09/20.
//  Copyright © 2020 HeartAcuityTeam. All rights reserved.
//


import UIKit

class SettingsViewController: UIViewController {
    

    var stroke: Bool = false
    var lungCancer: Bool = false
    var arrhymia: Bool = false
    
    @IBOutlet weak var strokeSetting: UIButton!
    @IBOutlet weak var lungCancerSetting: UIButton!
    @IBOutlet weak var arrhymiaSetting: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        stroke = UserDefaults.standard.bool(forKey: "stroke")
        lungCancer = UserDefaults.standard.bool(forKey: "detectCardiacArrest")
        arrhymia = UserDefaults.standard.bool(forKey: "arrhythmia")
        
    }
    func getBackgroundColor(setting: Bool) -> UIColor{
        if(setting){
            return .white
        } else {
            return UIColor(red:0.98, green:0.44, blue:0.37, alpha:1.0)
        }
    }
    @IBAction func strokeSettingClicked(_ sender: Any) {
        strokeSetting.backgroundColor = getBackgroundColor(setting: stroke)
        stroke = !stroke
        UserDefaults.standard.set(stroke, forKey: "stroke")
    }
    @IBAction func lungCancerSettingClicked(_ sender: Any) {
        lungCancerSetting.backgroundColor = getBackgroundColor(setting: lungCancer)
        lungCancer = !lungCancer
        UserDefaults.standard.set(lungCancer, forKey: "lungCancer")
    }
    @IBAction func arrhymiaSettingClicked(_ sender: Any) {
        arrhymiaSetting.backgroundColor = getBackgroundColor(setting: arrhymia)
        arrhymia = !arrhymia
        UserDefaults.standard.set(arrhymia, forKey: "arrhymia")
    }
}
