//
//  RYRCalendarHeaderStyle.swift
//  RYRCalendar
//
//  Created by Miquel, Aram on 07/06/2016.
//  Copyright © 2016 Ryanair. All rights reserved.
//

import UIKit

struct RYRCalendarHeaderStyle {
   var workDayFont: UIFont
   var workDayTextColor: UIColor
   var weekendDayFont: UIFont
   var weekendDayTextColor: UIColor
   var backgroundColor: UIColor
   
   init(workDayFont: UIFont, workDayTextColor: UIColor, weekendDayFont: UIFont, weekendDayTextColor: UIColor, backgroundColor: UIColor) {
      self.workDayFont = workDayFont
      self.workDayTextColor = workDayTextColor
      self.weekendDayFont = weekendDayFont
      self.weekendDayTextColor = weekendDayTextColor
      self.backgroundColor = backgroundColor
   }
}
