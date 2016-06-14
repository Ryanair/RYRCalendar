//
//  RYRCalendarHeaderView.swift
//  RYRCalendar
//
//  Created by Miquel, Aram on 02/06/2016.
//  Copyright © 2016 Ryanair. All rights reserved.
//

import UIKit

class RYRCalendarHeaderView: UIView {
   
   var mondayLabel: UILabel!
   var tuesdayLabel: UILabel!
   var wednesdayLabel: UILabel!
   var thursdayLabel: UILabel!
   var fridayLabel: UILabel!
   var saturdayLabel: UILabel!
   var sundayLabel: UILabel!
   
   var style: RYRCalendarHeaderStyle? { didSet { updateStyle(style!) } }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
   }
   
   private func setup() {
      self.backgroundColor = UIColor.blueColor()
      
      let components = NSDateComponents()
      components.calendar = NSCalendar.currentCalendar()
      
      components.day = 1
      mondayLabel = UILabel(frame: CGRectZero)
      mondayLabel.textAlignment = .Center
      mondayLabel.text = components.date?.getDayNumberAsString()
      
      components.day += 1
      tuesdayLabel = UILabel(frame: CGRectZero)
      tuesdayLabel.textAlignment = .Center
      tuesdayLabel.text = components.date?.getDayNumberAsString()
      
      components.day += 1
      wednesdayLabel = UILabel(frame: CGRectZero)
      wednesdayLabel.textAlignment = .Center
      wednesdayLabel.text = components.date?.getDayNumberAsString()
      
      components.day += 1
      thursdayLabel = UILabel(frame: CGRectZero)
      thursdayLabel.textAlignment = .Center
      thursdayLabel.text = components.date?.getDayNumberAsString()
      
      components.day += 1
      fridayLabel = UILabel(frame: CGRectZero)
      fridayLabel.textAlignment = .Center
      fridayLabel.text = components.date?.getDayNumberAsString()
      
      components.day += 1
      saturdayLabel = UILabel(frame: CGRectZero)
      saturdayLabel.textAlignment = .Center
      saturdayLabel.text = components.date?.getDayNumberAsString()
      
      components.day += 1
      sundayLabel = UILabel(frame: CGRectZero)
      sundayLabel.textAlignment = .Center
      sundayLabel.text = components.date?.getDayNumberAsString()
      
      addSubview(mondayLabel)
      addSubview(tuesdayLabel)
      addSubview(wednesdayLabel)
      addSubview(thursdayLabel)
      addSubview(fridayLabel)
      addSubview(saturdayLabel)
      addSubview(sundayLabel)
      
      mondayLabel.translatesAutoresizingMaskIntoConstraints = false
      tuesdayLabel.translatesAutoresizingMaskIntoConstraints = false
      wednesdayLabel.translatesAutoresizingMaskIntoConstraints = false
      thursdayLabel.translatesAutoresizingMaskIntoConstraints = false
      fridayLabel.translatesAutoresizingMaskIntoConstraints = false
      saturdayLabel.translatesAutoresizingMaskIntoConstraints = false
      sundayLabel.translatesAutoresizingMaskIntoConstraints = false
      
      addConstraints(NSLayoutConstraint.constraintsForEvenDistributionOfItems([mondayLabel, tuesdayLabel, wednesdayLabel, thursdayLabel, fridayLabel, saturdayLabel, sundayLabel], relativeToCenterOf: self, vertically: false))
      
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[label]-0-|", options: [], metrics: nil, views: ["label": mondayLabel]))
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[label]-0-|", options: [], metrics: nil, views: ["label": tuesdayLabel]))
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[label]-0-|", options: [], metrics: nil, views: ["label": wednesdayLabel]))
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[label]-0-|", options: [], metrics: nil, views: ["label": thursdayLabel]))
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[label]-0-|", options: [], metrics: nil, views: ["label": fridayLabel]))
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[label]-0-|", options: [], metrics: nil, views: ["label": saturdayLabel]))
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[label]-0-|", options: [], metrics: nil, views: ["label": sundayLabel]))
   }
   
   func updateStyle(newStyle: RYRCalendarHeaderStyle) {
      mondayLabel.font = newStyle.workDayFont
      tuesdayLabel.font = newStyle.workDayFont
      wednesdayLabel.font = newStyle.workDayFont
      thursdayLabel.font = newStyle.workDayFont
      fridayLabel.font = newStyle.workDayFont
      saturdayLabel.font = newStyle.weekendDayFont
      sundayLabel.font = newStyle.weekendDayFont
      
      mondayLabel.textColor = newStyle.workDayTextColor
      tuesdayLabel.textColor = newStyle.workDayTextColor
      wednesdayLabel.textColor = newStyle.workDayTextColor
      thursdayLabel.textColor = newStyle.workDayTextColor
      fridayLabel.textColor = newStyle.workDayTextColor
      saturdayLabel.textColor = newStyle.weekendDayTextColor
      sundayLabel.textColor = newStyle.weekendDayTextColor
      
      backgroundColor = newStyle.backgroundColor
   }
}

private extension NSLayoutConstraint {
   class func constraintsForEvenDistributionOfItems(items: [UIView], relativeToCenterOf mainView: UIView, vertically: Bool) -> [NSLayoutConstraint] {
      var constraints: [NSLayoutConstraint] = []
      let attribute: NSLayoutAttribute = vertically ? .CenterY : .CenterX
      
      for (index, view) in items.enumerate() {
         let multiplier: CGFloat = ((CGFloat)(2 * index + 1) / (CGFloat)(items.count))
         let constraint = NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .Equal, toItem: mainView, attribute: attribute, multiplier: multiplier, constant: 0)
         constraints.append(constraint)
      }
      
      return constraints
   }
}