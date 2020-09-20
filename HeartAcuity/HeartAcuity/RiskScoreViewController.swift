//
//  RiskScoreViewController.swift
//  HeartAcuity
//
//  Created by Abishek on 19/09/20.
//  Copyright © 2020 HeartAcuityTeam. All rights reserved.
//

import UIKit

class RiskScoreViewController: UIViewController {
    
    
    @IBOutlet weak var strokeView: UIView!
    
    @IBOutlet weak var arrhythmiaView: UIView!
    
    @IBOutlet weak var cardiacArrestView: UIView!
    
    @IBOutlet weak var strokeScoreView: UIView!
    
    @IBOutlet weak var arrhythmiaScoreView: UIView!
    @IBOutlet weak var cardiacArrestScoreView: UIView!
    
    
    @IBOutlet weak var strokeScore: UITextView!
    
    @IBOutlet weak var arrhythmiaScore: UITextView!
    
    @IBOutlet weak var cardiacArrestScore: UITextView!
    
    
    @IBOutlet weak var cardiacArrest: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let detectStroke = UserDefaults.standard.bool(forKey: "stroke")
        let detectArrythmia = UserDefaults.standard.bool(forKey: "arrhythmia")
        let detectCardiacArrest = UserDefaults.standard.bool(forKey: "detectCardiacArrest")
        let inputStrokeScore = UserDefaults.standard.double(forKey: "strokeScore")
        let inputArrythmiaScore = UserDefaults.standard.double(forKey: "arrythmiaScore")
        let inputCardiacArrestScore = UserDefaults.standard.double(forKey: "cardiacArrestScore")
        
        strokeScoreView.isHidden = detectStroke
        arrhythmiaScoreView.isHidden = detectArrythmia
        cardiacArrestScoreView.isHidden = detectCardiacArrest
        
        strokeView.isHidden = detectStroke
        arrhythmiaView.isHidden = detectArrythmia
        cardiacArrestView.isHidden = detectCardiacArrest
        
        strokeScore.text = String(inputStrokeScore)
        arrhythmiaScore.text = String(inputArrythmiaScore)
        cardiacArrestScore.text = String(inputCardiacArrestScore)
    }
    
}
