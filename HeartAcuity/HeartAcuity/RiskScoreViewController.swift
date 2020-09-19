//
//  RiskScoreViewController.swift
//  HeartAcuity
//
//  Created by Abishek on 19/09/20.
//  Copyright © 2020 HeartAcuityTeam. All rights reserved.
//

import UIKit

class RiskScoreViewController: UIViewController {

    
    @IBOutlet weak var AilmentsTab: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let detectStroke = UserDefaults.standard.bool(forKey: "detectStroke")
        let detectArrythmia = UserDefaults.standard.bool(forKey: "detectArrhythmia")
        let detectCardiacArrest = UserDefaults.standard.bool(forKey: "detectCardiacArrest")
        
        for UIView in AilmentsTab.arrangedSubviews {
            UIView.isHidden = detect
        }
        
        AilmentsTab.arrangedSubviews
    }
    
}
