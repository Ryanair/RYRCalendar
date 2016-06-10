//
//  RYRDayCellStyle.swift
//  RYRCalendar
//
//  Created by Miquel, Aram on 07/06/2016.
//  Copyright © 2016 Ryanair. All rights reserved.
//

import UIKit

struct RYRDayCellStyle {
   var backgroundColor: UIColor
   var backgroundImage: UIImage?
   var backgroundImageContentMode: UIViewContentMode
   var textFont: UIFont
   var textColor: UIColor
   
   init(backgroundColor: UIColor, backgroundImage: UIImage?, backgroundImageContentMode: UIViewContentMode = .Center, textFont: UIFont, textColor: UIColor) {
      self.backgroundColor = backgroundColor
      self.backgroundImage = backgroundImage
      self.backgroundImageContentMode = backgroundImageContentMode
      self.textFont = textFont
      self.textColor = textColor
   }
}
