//
//  ScoreCalculatorViewController.swift
//  HeartAcuity
//
//  Created by Eliot Huh on 9/19/20.
//  Copyright © 2020 HeartAcuityTeam. All rights reserved.
//

import UIKit

class ScoreCalculatorViewController: UIViewController {
    
    @IBOutlet weak var ageEntry: UITextField!
    
    @IBOutlet weak var heightEntry: UITextField!
    
    @IBOutlet weak var weightEntry: UITextField!
    
    @IBOutlet weak var genderTab: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageEntry.text = String(UserDefaults.standard.double(forKey: "age"))
        heightEntry.text = String(UserDefaults.standard.double(forKey: "height"))
        weightEntry.text = String(UserDefaults.standard.(forKey: "detectCardiacArrest"))
        let strokeScore = UserDefaults.standard.double(forKey: "detectStroke")
        let arrythmiaScore = UserDefaults.standard.double(forKey: "detectArrhythmia")
        let cardiacArrestScore = UserDefaults.standard.double(forKey: "detectCardiacArrest")
    }

    
    @IBAction func ageField(_ sender: Any){
            if let value = ageEntry.text {
                UserDefaults.standard.set(Double(value), forKey: "age")
            }
        
            else {
                UserDefaults.standard.set(-1, forKey: "age")
            }
    }
    
    
    @IBAction func heightField(_ sender: Any){
            if let value = heightEntry.text {
                UserDefaults.standard.set(Double(value), forKey: "height")
            }
        
            else {
                UserDefaults.standard.set(-1, forKey: "height")
            }
    }
    
    @IBAction func weightField(_ sender: Any){
            if let value = weightEntry.text {
                UserDefaults.standard.set(Double(value), forKey: "weight")
            }
        
            else {
                UserDefaults.standard.set(0, forKey: "weight")
            }
    }
    
    @IBAction func genderInput(_ sender: Any) {
    }
    
    @IBAction func smokerInput(_ sender: Any) {
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        
    }
    
}
