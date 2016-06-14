//
//  ViewController.swift
//  RYRCalendar
//
//  Created by Miquel, Aram on 06/14/2016.
//  Copyright (c) 2016 Miquel, Aram. All rights reserved.
//

import UIKit
import RYRCalendar

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
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
}

extension ViewController: RYRCalendarDelegate {
   func calendarDidSelectMultipleDate(calendar: RYRCalendar, selectedStartDate startDate: NSDate, endDate: NSDate) {
      let formatter = NSDateFormatter()
      formatter.dateFormat = "dd-MM-yyyy"
      
      print("Start: \(formatter.stringFromDate(startDate)) || End: \(formatter.stringFromDate(endDate))")
   }
   
   func calendarDidSelectDate(calendar: RYRCalendar, selectedDate: NSDate) {
      let formatter = NSDateFormatter()
      formatter.dateFormat = "dd-MM-yyyy"
      
      print(formatter.stringFromDate(selectedDate))
   }
   
   func isDateAvailableToSelect(date: NSDate) -> Bool {
      return true
   }
   
   func calendarDidScrollToMonth(calendar: RYRCalendar, monthDate: NSDate) {
      let formatter = NSDateFormatter()
      formatter.dateFormat = "dd-MM-yyyy"
      
      print("Did scroll to date: \(formatter.stringFromDate(monthDate))")
   }
}