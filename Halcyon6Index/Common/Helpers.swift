//
//  Helpers.swift
//  Halcyon6Index
//
//  Created by Louis Tur on 9/18/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

internal func hexStringToUIColor(_ hex: String) -> UIColor {
  var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
  
  
  // TODO: test this Swift3 converted call
  if (cString.hasPrefix("#")) {
    cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
  }
  
  if ((cString.characters.count) != 6) {
    return UIColor.gray
  }
  
  var rgbValue:UInt32 = 0
  Scanner(string: cString).scanHexInt32(&rgbValue)
  
  return UIColor(
    red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
    green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
    blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
    alpha: CGFloat(1.0)
  )
}

internal func rgbComponentsFrom(_ color: UIColor) -> (r: CGFloat, g: CGFloat, b: CGFloat) {
  var redComponent: CGFloat = 0.0,
  blueComponent: CGFloat = 0.0,
  greenComponent: CGFloat = 0.0,
  alphaComponent: CGFloat = 0.0
  
  color.getRed(&redComponent, green: &greenComponent, blue: &blueComponent, alpha: &alphaComponent)
  
  let redValueRGB = redComponent * 255.0
  let greenValueRGB = greenComponent * 255.0
  let blueValueRGB = blueComponent * 255.0
  
  return (redValueRGB, greenValueRGB, blueValueRGB)
}

internal func hexValueFrom(color: UIColor) -> (String) {
  let (red, green, blue) = rgbComponentsFrom(color)
  let redValueHex = String(UInt32(red), radix: 16, uppercase: true)
  let greenValueHex = String(UInt32(green), radix: 16, uppercase: true)
  let blueValueHex = String(UInt32(blue), radix: 16, uppercase: true)
  
  return "\(redValueHex)\(greenValueHex)\(blueValueHex)"
}
