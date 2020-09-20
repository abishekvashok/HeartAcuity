//
//  ScoreCalculatorViewController.swift
//  HeartAcuity
//
//  Created by Eliot Huh on 9/19/20.
//  Copyright © 2020 HeartAcuityTeam. All rights reserved.
//

import UIKit
import HealthKit
import CoreML

class ScoreCalculatorViewController: UIViewController {
    
    @IBOutlet weak var ageEntry: UITextField!
    
    @IBOutlet weak var heightEntry: UITextField!
    
    @IBOutlet weak var weightEntry: UITextField!
    
    @IBOutlet weak var genderTab: UISegmentedControl!
    
    @IBOutlet weak var isSmoker: UISegmentedControl!
    
    @IBOutlet weak var calculateRisk: UIButton!
    
    @IBOutlet weak var rrContainer: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageEntry.text = String(UserDefaults.standard.double(forKey: "age"))
        heightEntry.text = String(UserDefaults.standard.double(forKey: "height"))
        weightEntry.text = String(UserDefaults.standard.double(forKey: "weight"))
    }
    
    @IBAction func CalculateRisk(_ sender: Any) {
        
        let cardiacArrestModel = HA_SVM_cardiacarrest_coreml()
        let strokeModel = RF_stroke_coreml()
        let arrhythmiaModel = HA_SVM_arrhythmia_coreml()
            //gender, age, height, weight, family history, hrv
        let age = Double(ageEntry.text!)
        let height = Double(177)
        let weight = Double(130)
        let gender = Double(genderTab.selectedSegmentIndex)
        let smoking = Double(isSmoker.selectedSegmentIndex)
        let rrVal =  Double(rrContainer.text!)
        
        do {
            let cardiacArrestParams = try MLMultiArray(shape: [6], dataType: .double)
            cardiacArrestParams[0] = NSNumber(value: genderTab.selectedSegmentIndex)
            cardiacArrestParams[1] = Double(ageEntry.text!) as! NSNumber
            cardiacArrestParams[2] = Double(heightEntry.text!) as! NSNumber
            cardiacArrestParams[3] = Double(weightEntry.text!) as! NSNumber
            cardiacArrestParams[4] = NSNumber(value: isSmoker.selectedSegmentIndex)
            cardiacArrestParams[5] = Double(rrContainer.text!) as! NSNumber
            guard let cardiacArrestScore = try? cardiacArrestModel.prediction(patient_data: cardiacArrestParams)
            else{
                return
            }
            UserDefaults.standard.set(Double(cardiacArrestScore.stroke_risk), forKey: "cardiacArrestScore")
            
        } catch {
            print("Error")
        }
        
        do {
            let strokeParams = try MLMultiArray(shape: [6], dataType: .double)
            strokeParams[0] = NSNumber(value: genderTab.selectedSegmentIndex)
            strokeParams[1] = Double(ageEntry.text!) as! NSNumber
            strokeParams[2] = Double(heightEntry.text!) as! NSNumber
            strokeParams[3] = Double(weightEntry.text!) as! NSNumber
            strokeParams[4] = NSNumber(value: isSmoker.selectedSegmentIndex)
            strokeParams[5] = Double(rrContainer.text!) as! NSNumber
            guard let strokeScore = try? strokeModel.prediction(input: strokeParams)
            else{
                return
            }
            UserDefaults.standard.set(Double(strokeScore.prediction), forKey: "strokeScore")
            
        } catch {
            print("Error")
        }
        
        do {
            let arrhythmiaParams = try MLMultiArray(shape: [6], dataType: .double)
            arrhythmiaParams[0] = NSNumber(value: genderTab.selectedSegmentIndex)
            arrhythmiaParams[1] = Double(ageEntry.text!) as! NSNumber
            arrhythmiaParams[2] = Double(heightEntry.text!) as! NSNumber
            arrhythmiaParams[3] = Double(weightEntry.text!) as! NSNumber
            arrhythmiaParams[4] = NSNumber(value: isSmoker.selectedSegmentIndex)
            arrhythmiaParams[5] = Double(rrContainer.text!) as! NSNumber
            guard let arrhythmiaScore = try? arrhythmiaModel.prediction(patient_data: arrhythmiaParams)
            else {
                return
            }
            UserDefaults.standard.set(Double(arrhythmiaScore.stroke_risk), forKey: "arrhythmiaScore")
            
        } catch {
            print("Error")
        }
        
        
    }
    
    
    @IBAction func calculateRRInteveral(_ sender: Any) {
        if HKHealthStore.isHealthDataAvailable() {
            let healthStore = HKHealthStore()
            let allTypes = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])

            healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
                if success {
                    // Create the electrocardiogram sample type.
                    if #available(iOS 14.0, *) {
                        let ecgType = HKObjectType.electrocardiogramType()
                        var armmsd = 0
                        var l = 0
                        let ecgQuery = HKSampleQuery(sampleType: ecgType,
                                                     predicate: nil,
                                                     limit: HKObjectQueryNoLimit,
                                                     sortDescriptors: nil) { (query, samples, error) in
                            l = l + 1
                            if let error = error {
                                // Handle the error here.
                                fatalError("*** An error occurred \(error.localizedDescription) ***")
                            }
                     
                            guard let ecgSamples = samples as? [HKElectrocardiogram] else {
                                fatalError("*** Unable to convert \(String(describing: samples)) to [HKElectrocardiogram] ***")
                            }
                            
                            for sample in ecgSamples {
                                var i = 0
                                var j = 0
                                var startI = 0
                                var k = 0
                                var avg = 0
                                var rmssd = 0
                                let voltageQuery = HKElectrocardiogramQuery(sample) { (query, result) in
                                    switch(result) {
                                    
                                    case .measurement(let measurement):
                                        if let voltageQuantity = measurement.quantity(for: .appleWatchSimilarToLeadI) {
                                            i = i + 1
                                            let value = Int(voltageQuantity.doubleValue(for: HKUnit.count()))
                                            if(value > 1 && j == 0){
                                                if(i == 1){
                                                    startI = i
                                                } else {
                                                    var diff = i - startI
                                                    diff = diff / 125
                                                    diff = diff * diff
                                                    k = k + 1
                                                    avg = avg + diff
                                                }
                                                j = 1
                                            } else {
                                                j = 0
                                            }
                                        }

                                    case .error(let error):
                                        // Handle the error here.
                                        print("Error")
                                        rmssd = avg/k
                                        armmsd += rmssd
                                    case .done:
                                        print("Done")
                                    }
                                }


                                // Execute the query.
                                healthStore.execute(voltageQuery)
                            }
                            if(l != 0){
                                armmsd = armmsd / l
                                self.rrContainer.text = String(armmsd)
                            }
                        }
                        healthStore.execute(ecgQuery)
                    } else {
                         self.rrContainer.text = ".078"
                    }


                    // Query for electrocardiogram samples
                }
            }
        }
    }
}
