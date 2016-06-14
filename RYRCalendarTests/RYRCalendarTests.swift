//
//  RYRCalendarTests.swift
//  RYRCalendarTests
//
//  Created by Miquel, Aram on 01/06/2016.
//  Copyright © 2016 Ryanair. All rights reserved.
//

import XCTest
@testable import RYRCalendar

class RYRCalendarTests: XCTestCase {
   func testGetBlankSpaces() {
      let myCalendar = RYRCalendar()
      
      let formatter = NSDateFormatter()
      formatter.dateFormat = "dd-MM-yyyy"
      
      var dateString = "01-01-2016"
      var date = formatter.dateFromString(dateString)
      var blankSpaces = myCalendar.getBlankSpaces(date)
      XCTAssertTrue(blankSpaces == 4)
      
      // Proove about the -2 in the getBlankSpaces
      let calendar = NSCalendar.currentCalendar()
      let components = calendar.components([.Weekday], fromDate: date!)
      XCTAssertTrue(components.weekday == 6)
      
      dateString = "03-01-2016"
      date = formatter.dateFromString(dateString)
      blankSpaces = myCalendar.getBlankSpaces(date?.setToFirstDayOfMonth())
      XCTAssertTrue(blankSpaces == 4)
   }
}
