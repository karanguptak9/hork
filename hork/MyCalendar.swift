//
//  CalenderViewController.swift
//  hork
//
//  Created by Karan Gupta on 4/17/18.
//  Copyright © 2018 Karan Gupta. All rights reserved.
//

import Foundation
import UIKit
        //having one function in the end
class MyCalendar: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        //need connection of collection view and labels (only the things that are changing)
    @IBOutlet weak var calendar: UICollectionView!
    @IBOutlet weak var timeLabel: UILabel!

    var currentYear = Calendar.current.component(.year, from: Date())
    var currentMonth = Calendar.current.component(.month, from: Date())
        //hardcoding number of months
    var months = ["January", "February", "March",
                  "April", "May", "June",
                  "July","Auguest", "September",
                  "October", "November", "December"]
        //solving next month issue after year end after Dec
    @IBAction func nextMonth(_ sender: UIButton) {
        currentMonth = currentMonth + 1
        if currentMonth == 13 {
            currentMonth = 1
            currentYear = currentYear + 1
        }
        update()
    }
        //solving last month going back from Jan
    @IBAction func lastMonth(_ sender: UIButton) {
        currentMonth = currentMonth - 1
        if currentMonth == 0 {
            currentMonth = 12
            currentYear = currentYear - 1
        }
        update()
    }
        //updating days according to month, use predefined component of calendar.
    var numberOfDaysInThisMonth:Int {
        let dateComponents = DateComponents(year: currentYear , month: currentMonth)
        let datey = Calendar.current.date(from: dateComponents)!
        let range = Calendar.current.range(of: .day, in: .month, for: datey)
        return range?.count ?? 0
    }
    //display number of days in the current month
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDaysInThisMonth
    }
    //displaying each day in each cell
    //FIX IT
    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let textLabel = cell.contentView.subviews[0] as? UILabel {
            textLabel.text = "\(indexPath.row + 1)"
        }
        return cell
    }
        //changing month is needed to be changed and displayed
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        update()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        //need to update data everytime
    func update() {
        timeLabel.text = months[currentMonth - 1] + " \(currentYear)"
        calendar.reloadData()
    }
}
