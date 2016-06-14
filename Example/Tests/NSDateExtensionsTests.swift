//
//  NSDateExtensionsTests.swift
//  RYRCalendar
//
//  Created by Miquel, Aram on 13/06/2016.
//  Copyright © 2016 Ryanair. All rights reserved.
//

import XCTest
import RYRCalendar
@testable import RYRCalendar

class NSDateExtensionsTests: XCTestCase {
   func testNumberOfDaysInCurrentMonth() {
      
      let formatter = NSDateFormatter()
      formatter.dateFormat = "dd-MM-yyyy"
      
      var dateString = "16-06-2016"
      var date = formatter.dateFromString(dateString)!
      XCTAssertTrue(date.numberOfDaysInCurrentMonth() == 30)
      
      dateString = "01-06-2016"
      date = formatter.dateFromString(dateString)!
      XCTAssertTrue(date.numberOfDaysInCurrentMonth() == 30)
      
      dateString = "30-06-2016"
      date = formatter.dateFromString(dateString)!
      XCTAssertTrue(date.numberOfDaysInCurrentMonth() == 30)
      
      dateString = "03-10-2016"
      date = formatter.dateFromString(dateString)!
      XCTAssertTrue(date.numberOfDaysInCurrentMonth() == 31)
   }
   
   func testDateByAddingMonths() {
      let calendar = NSCalendar.currentCalendar()
      let components = NSDateComponents()
      
      components.day = 3
      components.month = 1
      components.year = 2016
      
      let januaryDate = calendar.dateFromComponents(components)!
      let februaryDate = januaryDate.dateByAddingMonths(1)!
      
      XCTAssertTrue(calendar.component(.Month, fromDate: februaryDate) == 2)
      XCTAssertTrue(calendar.component(.Day, fromDate: februaryDate) == components.day)
      XCTAssertTrue(calendar.component(.Year, fromDate: februaryDate) == components.year)
      
      components.month = 12
      let decemberDate = calendar.dateFromComponents(components)!
      let nextYearDate = decemberDate.dateByAddingMonths(1)!
      
      XCTAssertTrue(calendar.component(.Month, fromDate: nextYearDate) == 1)
      XCTAssertTrue(calendar.component(.Day, fromDate: nextYearDate) == components.day)
      XCTAssertTrue(calendar.component(.Year, fromDate: nextYearDate) == 2017)
   }
   
   func testDateByAddingDays() {
      let calendar = NSCalendar.currentCalendar()
      let components = NSDateComponents()
      
      components.day = 1
      components.month = 1
      components.year = 2016
      let fridayDate = calendar.dateFromComponents(components)!
      let saturdayDate = fridayDate.dateByAddingDays(1)!
      
      XCTAssertTrue(calendar.component(.Day, fromDate: saturdayDate) == 2)
      XCTAssertTrue(calendar.component(.Month, fromDate: saturdayDate) == components.month)
      XCTAssertTrue(calendar.component(.Year, fromDate: saturdayDate) == components.year)
      
      components.day = 31
      let lastDayInMonthDate = calendar.dateFromComponents(components)!
      let nextMonthDate = lastDayInMonthDate.dateByAddingDays(1)!
      
      XCTAssertTrue(calendar.component(.Day, fromDate: nextMonthDate) == 1)
      XCTAssertTrue(calendar.component(.Month, fromDate: nextMonthDate) == 2)
      XCTAssertTrue(calendar.component(.Year, fromDate: nextMonthDate) == components.year)
      
      components.day = 31
      components.month = 12
      components.year = 2016
      let lastDayOfYearDate = calendar.dateFromComponents(components)!
      let firstDayNextYearDate = lastDayOfYearDate.dateByAddingDays(1)!
      XCTAssertTrue(calendar.component(.Day, fromDate: firstDayNextYearDate) == 1)
      XCTAssertTrue(calendar.component(.Month, fromDate: firstDayNextYearDate) == 1)
      XCTAssertTrue(calendar.component(.Year, fromDate: firstDayNextYearDate) == 2017)
   }
   
   func testSetDateToFirstDayOfMonth() {
      let calendar = NSCalendar.currentCalendar()
      let components = NSDateComponents()
      
      components.day = 12
      components.month = 1
      components.year = 2016
      let middleDate = calendar.dateFromComponents(components)!
      let firstDayDate = middleDate.setToFirstDayOfMonth()!
      
      XCTAssertTrue(calendar.component(.Day, fromDate: firstDayDate) == 1)
      XCTAssertTrue(calendar.component(.Month, fromDate: firstDayDate) == 1)
      XCTAssertTrue(calendar.component(.Year, fromDate: firstDayDate) == 2016)
   }
   
   func testIsPastDay() {
      let formatter = NSDateFormatter()
      formatter.dateFormat = "dd-MM-yyyy"
      
      let previousDateString = "16-06-2014"
      let previousDate = formatter.dateFromString(previousDateString)!
      
      XCTAssertTrue(previousDate.isPastDay())
      
      let calendar = NSCalendar.currentCalendar()
      let components = calendar.components([.Day, .Year, .Month], fromDate: NSDate())
      
      XCTAssertFalse(calendar.dateFromComponents(components)!.isPastDay())
      
      components.day -= 1
      
      XCTAssertTrue(calendar.dateFromComponents(components)!.isPastDay())
   }
   
   func testIsToday() {
      let currentDate = NSDate()
      XCTAssertTrue(currentDate.isToday())
      
      let formatter = NSDateFormatter()
      formatter.dateFormat = "dd-MM-yyyy"
      
      let previousDateString = "16-06-2014"
      XCTAssertFalse(formatter.dateFromString(previousDateString)!.isToday())
      
      let calendar = NSCalendar.currentCalendar()
      let components = calendar.components([.Day, .Month, .Year], fromDate: currentDate)
      XCTAssertTrue(calendar.dateFromComponents(components)!.isToday())
   }
   
   func testIsDateBetweenDates() {
      let formatter = NSDateFormatter()
      formatter.dateFormat = "dd-MM-yyyy"
      
      let dateOneString = "01-01-2014"
      let dateTwoString = "01-01-2015"
      
      let dateOne = formatter.dateFromString(dateOneString)
      let dateTwo = formatter.dateFromString(dateTwoString)
      
      var dateThreeString = "02-01-2014"
      var dateThree = formatter.dateFromString(dateThreeString)!
      
      XCTAssertTrue(dateThree.isBetweenDates(dateOne, secondDate: dateTwo))
      XCTAssertFalse(NSDate().isBetweenDates(dateOne, secondDate: dateTwo))
      
      dateThreeString = "31-12-2014"
      dateThree = formatter.dateFromString(dateThreeString)!
      XCTAssertTrue(dateThree.isBetweenDates(dateOne, secondDate: dateTwo))
   }
}
