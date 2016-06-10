//
//  ViewController.swift
//  RYRCalendar
//
//  Created by Miquel, Aram on 01/06/2016.
//  Copyright © 2016 Ryanair. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   @IBOutlet weak var calendar: RYRCalendar!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view, typically from a nib.
      calendar.delegate = self
      calendar.selectionType = .Multiple
      calendar.totalMonthsFromNow = 6
      calendar.update()
   }
}


extension ViewController: RYRCalendarDelegate {
   func calendarDidSelectMultipleDate(calendar: RYRCalendar, selectedStartDate startDate: NSDate, endDate: NSDate) {
      print("Start: \(startDate) || End: \(endDate)")
   }
   func calendarDidSelectDate(calendar: RYRCalendar, selectedDate: NSDate) {
      print(selectedDate)
   }
   
   func isDateAvailableToSelect(date: NSDate) -> Bool {
      return true
   }
   
   func calendarDidScrollToMonth(calendar: RYRCalendar, monthDate: NSDate) {
      print("Did scroll to date: \(monthDate)")
   }
}