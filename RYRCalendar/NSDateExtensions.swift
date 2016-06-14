//
//  NSDateExtensions.swift
//  RYRCalendar
//
//  Created by Miquel, Aram on 13/06/2016.
//  Copyright © 2016 Ryanair. All rights reserved.
//

import UIKit

internal extension NSDate {
   func numberOfDaysInCurrentMonth() -> Int {
      return NSCalendar.currentCalendar().rangeOfUnit(.Day, inUnit: .Month, forDate: self).length
   }
   
   func dateByAddingMonths(monthsToAdd: Int) -> NSDate? {
      if #available(iOS 8.0, *) {
         return NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: monthsToAdd, toDate: self, options: [])
      } else {
         let components = NSDateComponents()
         components.month = monthsToAdd
         return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self, options: [])
      }
   }
   
   func setToFirstDayOfMonth() -> NSDate? {
      let calendar = NSCalendar.currentCalendar()
      let components = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month], fromDate: self)
      return calendar.dateFromComponents(components)
   }
   
   func dateByAddingDays(daysToAdd: Int) -> NSDate? {
      if #available(iOS 8.0, *) {
         return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: daysToAdd, toDate: self, options: [])
      } else {
         let components = NSDateComponents()
         components.day = daysToAdd
         return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self, options: [])
      }
   }
   
   func isPastDay() -> Bool {
      let calendar = NSCalendar.currentCalendar()
      let components = calendar.components([.Year, .Day, .Month], fromDate: NSDate())
      return compare(calendar.dateFromComponents(components)!) == .OrderedAscending
   }
   
   func isToday() -> Bool {
      if #available(iOS 8.0, *) {
         return  NSCalendar.currentCalendar().isDateInToday(self)
      } else {
         let calendar = NSCalendar.currentCalendar()
         let todayComponents = calendar.components([.Year, .Month, .Day], fromDate: NSDate())
         let selfComponents = calendar.components([.Year, .Month, .Day], fromDate: self)
         
         return calendar.dateFromComponents(todayComponents)!.isEqualToDate(calendar.dateFromComponents(selfComponents)!)
      }
   }
   
   func isBetweenDates(firstDate: NSDate?, secondDate: NSDate?) -> Bool {
      guard let firstDate = firstDate, secondDate = secondDate else { return false }
      return firstDate.compare(self) == self.compare(secondDate)
   }
   
   func getDayNumberAsString() -> String {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "E"
      return dateFormatter.stringFromDate(self)
   }
   
   func getMonthAsString() -> String {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "MMM"
      return dateFormatter.stringFromDate(self)
   }
   
   func getYearAsString() -> String {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "yyyy"
      return dateFormatter.stringFromDate(self)
   }
}