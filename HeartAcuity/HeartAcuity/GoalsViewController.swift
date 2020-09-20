//
//  GoalsViewController.swift
//  HeartAcuity
//
//  Created by Abishek on 19/09/20.
//  Copyright © 2020 HeartAcuityTeam. All rights reserved.
//

import UIKit
import HealthKit

class GoalsViewController: UIViewController {

    @IBOutlet weak var walkingProgress: UIProgressView!
    @IBOutlet var sleepingProgress: [UIProgressView]!
    @IBOutlet weak var progressLabel: UILabel!
    @IBAction func fbButtonclicked(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.facebook.com/sharer/sharer.php?u=https://sandratang.github.io/heartacuity.html&quote=Working out for a better tommorrow")!, options: [:], completionHandler: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if HKHealthStore.isHealthDataAvailable() {
            let healthStore = HKHealthStore()
            guard let type = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning) else {
                fatalError("Something went wrong retrieving quantity type distanceWalkingRunning")
            }
            let allTypes = Set([HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!])

            healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
                if !success {
                    print()
                }
            }
            let date =  Date()
            let cal = Calendar(identifier: Calendar.Identifier.gregorian)
            let newDate = cal.startOfDay(for: date)

            let predicate = HKQuery.predicateForSamples(withStart: newDate, end: Date(), options: .strictStartDate)

            let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: [.cumulativeSum]) { (query, statistics, error) in
                var value: Double = 0

                if error != nil {
                    print("something went wrong")
                } else if let quantity = statistics?.sumQuantity() {
                    value = quantity.doubleValue(for: HKUnit.mile())
                }
                DispatchQueue.main.async {
                    self.completion(val: value)
                }
            }
            healthStore.execute(query)
        }
    }
    func completion(val: Double){
        let value = (val / 7)*100
        walkingProgress.setProgress(Float(value), animated: false)
        progressLabel.text = String(value) + " out of 4 miles"
    }

}
