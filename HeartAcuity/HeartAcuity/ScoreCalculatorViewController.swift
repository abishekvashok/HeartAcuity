//
//  ScoreCalculatorViewController.swift
//  HeartAcuity
//
//  Created by Eliot Huh on 9/19/20.
//  Copyright © 2020 HeartAcuityTeam. All rights reserved.
//

import UIKit
import HealthKit

class ScoreCalculatorViewController: UIViewController {
    
    @IBOutlet weak var ageEntry: UITextField!
    
    @IBOutlet weak var heightEntry: UITextField!
    
    @IBOutlet weak var weightEntry: UITextField!
    
    @IBOutlet weak var genderTab: UISegmentedControl!
    
    @IBOutlet weak var isSmoker: UISegmentedControl!
    
    @IBOutlet weak var calculateRisk: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageEntry.text = String(UserDefaults.standard.double(forKey: "age"))
        heightEntry.text = String(UserDefaults.standard.double(forKey: "height"))
        weightEntry.text = String(UserDefaults.standard.double(forKey: "weight"))
        if HKHealthStore.isHealthDataAvailable() {
            let healthStore = HKHealthStore()
            let allTypes = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])

            healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
                if !success {
                    // Create the electrocardiogram sample type.
                    let ecgType = HKObjectType.electrocardiogramType()


                    // Query for electrocardiogram samples
                    let ecgQuery = HKSampleQuery(sampleType: ecgType,
                                                 predicate: nil,
                                                 limit: HKObjectQueryNoLimit,
                                                 sortDescriptors: nil) { (query, samples, error) in
                        if let error = error {
                            // Handle the error here.
                            fatalError("*** An error occurred \(error.localizedDescription) ***")
                        }
                        
                        guard let ecgSamples = samples as? [HKElectrocardiogram] else {
                            fatalError("*** Unable to convert \(String(describing: samples)) to [HKElectrocardiogram] ***")
                        }
                        
                        for sample in ecgSamples {
                            let voltageQuery = HKElectrocardiogramQuery(sample) { (query, result) in
                                switch(result) {
                                
                                case .measurement(let measurement):
                                    if let voltageQuantity = measurement.quantity(for: .appleWatchSimilarToLeadI) {
                                        // Do something with the voltage quantity here.

                                    }

                                case .error(let error):
                                    // Handle the error here.
                                    print("Error")
                                }
                            }

                            // Execute the query.
                            healthStore.execute(voltageQuery)
                        }
                    }
                    healthStore.execute(ecgQuery)
                }
            }
        }
    }
    
    @IBAction func CalculateRisk(_ sender: Any) {
    
        let model = HA_xgb_test_coreml()
        
        guard let modelOutput = try? model.prediction(policyID: 1.1, eq_site_limit: 1.1, hu_site_limit: 1.1, fl_site_limit: 1.1, fr_site_limit: 1.1, tiv_2011: 1.1, tiv_2012: 1.1, eq_site_deductible: 1.1, hu_site_deductible: 1.1, fl_site_deductible: 1.1, fr_site_deductible: 1.1, point_latitude: 1.1, point_longitude: 1.1, point_granularity: 1.1, statecode_ohe_0: 1.1, county_ohe_0: 1.1, county_ohe_1: 1.1, county_ohe_2: 1.1, county_ohe_3: 1.1, county_ohe_4: 1.1, county_ohe_5: 1.1, county_ohe_6: 1.1, county_ohe_7: 1.1, county_ohe_8: 1.1, county_ohe_9: 1.1, county_ohe_10: 1.1, county_ohe_11: 1.1, county_ohe_12: 1.1, county_ohe_13: 1.1, county_ohe_14: 1.1, county_ohe_15: 1.1, county_ohe_16: 1.1, county_ohe_17: 1.1, county_ohe_18: 1.1, county_ohe_19: 1.1, county_ohe_20: 1.1, county_ohe_21: 1.1, county_ohe_22: 1.1, county_ohe_23: 1.1, county_ohe_24: 1.1, county_ohe_25: 1.1, county_ohe_26: 1.1, county_ohe_27: 1.1, county_ohe_28: 1.1, county_ohe_29: 1.1, county_ohe_30: 1.1, county_ohe_31: 1.1, county_ohe_32: 1.1, county_ohe_33: 1.1, county_ohe_34: 1.1, county_ohe_35: 1.1, county_ohe_36: 1.1, county_ohe_37: 1.1, county_ohe_38: 1.1, county_ohe_39: 1.1, county_ohe_40: 1.1, county_ohe_41: 1.1, county_ohe_42: 1.1, county_ohe_43: 1.1, county_ohe_44: 1.1, county_ohe_45: 1.1, county_ohe_46: 1.1, county_ohe_47: 1.1, county_ohe_48: 1.1, county_ohe_49: 1.1, county_ohe_50: 1.1, county_ohe_51: 1.1, county_ohe_52: 1.1, county_ohe_53: 1.1, county_ohe_54: 1.1, county_ohe_55: 1.1, county_ohe_56: 1.1, county_ohe_57: 1.1, county_ohe_58: 1.1, county_ohe_59: 1.1, county_ohe_60: 1.1, county_ohe_61: 1.1, county_ohe_62: 1.1, county_ohe_63: 1.1, county_ohe_64: 1.1, county_ohe_65: 1.1, county_ohe_66: 1.1, line_ohe_0: 1.1, line_ohe_1: 1.1, construction_ohe_0: 1.1, construction_ohe_1: 1.1, construction_ohe_2: 1.1, construction_ohe_3: 1.1)
            else{
                fatalError("Unexpected runtime error.")
            }
        
        UserDefaults.standard.set(Double(modelOutput.classProbability[0]!), forKey: "strokeScore")
    }
    
    
}
