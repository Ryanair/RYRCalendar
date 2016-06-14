//
//  RYRCalendarDayCell.swift
//  RYRCalendar
//
//  Created by Miquel, Aram on 01/06/2016.
//  Copyright © 2016 Ryanair. All rights reserved.
//

import UIKit

class RYRDayCell: UICollectionViewCell {

   class var cellIndentifier: String { get { return "RYRCalendarDayCellIndentifier" } }
   
   private var dayNumberLabel: UILabel!
   private var backgroundImage: UIImageView?
   
   var dayNumber: Int = 0 { didSet { updateDayNumberLabel() } }
   var style: RYRDayCellStyle? { didSet { updateStyle(style!) } }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
   }
   
   private func setup() {
      
      dayNumberLabel = UILabel(frame: CGRectMake(0, 0, 40, 40))
      dayNumberLabel.textAlignment = NSTextAlignment.Center
      addSubview(dayNumberLabel)
      
      dayNumberLabel.translatesAutoresizingMaskIntoConstraints = false
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[dayNumberLabel]-0-|", options: [], metrics: nil, views: ["dayNumberLabel": dayNumberLabel]))
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[dayNumberLabel]-0-|", options: [], metrics: nil, views: ["dayNumberLabel": dayNumberLabel]))
   }
      
   private func updateDayNumberLabel() {
      dayNumberLabel.text = "\(dayNumber)"
   }
   
   private func updateStyle(newStyle: RYRDayCellStyle) {
      backgroundColor = newStyle.backgroundColor
      dayNumberLabel.font = newStyle.textFont
      dayNumberLabel.textColor = newStyle.textColor
      
      backgroundImage?.removeFromSuperview()
      
      if let newBackgroundImage = newStyle.backgroundImage {
         
         backgroundImage = UIImageView(image: newBackgroundImage)
         backgroundImage?.contentMode = newStyle.backgroundImageContentMode
         addSubview(backgroundImage!)
         backgroundImage?.translatesAutoresizingMaskIntoConstraints = false
         addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[backgroundImage]-0-|", options: [], metrics: nil, views: ["backgroundImage": backgroundImage!]))
         addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[backgroundImage]-0-|", options: [], metrics: nil, views: ["backgroundImage": backgroundImage!]))
         sendSubviewToBack(backgroundImage!)
      }
   }
}