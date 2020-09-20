//
//  RiskScoreViewController.swift
//  HeartAcuity
//
//  Created by Abishek on 19/09/20.
//  Copyright © 2020 HeartAcuityTeam. All rights reserved.
//

import UIKit

class RiskScoreViewController: UIViewController {

    @IBOutlet weak var strokeScore: UITextView!
    
    @IBOutlet weak var arrhythmiaScore: UITextView!
    
    @IBOutlet weak var cardiacArrestScore: UITextView!
    
    @IBOutlet weak var ailmentsTab: UIStackView!
   
    @IBOutlet weak var strokeRisk: UITextView!
    
    @IBOutlet weak var arrhythmia: UITextView!
    
    
    @IBOutlet weak var cardiacArrest: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let detectStroke = UserDefaults.standard.bool(forKey: "detectStroke")
        let detectArrythmia = UserDefaults.standard.bool(forKey: "detectArrhythmia")
        let detectCardiacArrest = UserDefaults.standard.bool(forKey: "detectCardiacArrest")
        let inputStrokeScore = UserDefaults.standard.double(forKey: "strokeScore")
        let inputArrythmiaScore = UserDefaults.standard.double(forKey: "arrythmiaScore")
        let inputCardiacArrestScore = UserDefaults.standard.double(forKey: "cardiacArrestScore")
        
        strokeRisk.isHidden = detectStroke
        arrhythmia.isHidden = detectArrythmia
        cardiacArrest.isHidden = detectCardiacArrest
        
        strokeScore.text = String(inputStrokeScore)
        arrhythmiaScore.text = String(inputArrythmiaScore)
        cardiacArrestScore.text = String(inputCardiacArrestScore)
    }
    
}
