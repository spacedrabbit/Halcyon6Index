//
//  Constants.swift
//  Halcyon6Index
//
//  Created by Louis Tur on 9/18/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit


internal struct AppKeys {
  internal static let IndexCVCCellIdentifier: String = "indexCellIdentifier"
}

internal struct AppLayout {
  internal static let StandardMargin: CGFloat = 8.0
  internal static let StatusBar: CGFloat = 22.0
  internal static let MinimumCellSize: CGFloat = 100.0
}

internal struct AppColors {
  internal static let Diplomat: UIColor = hexStringToUIColor("#C6F362")
  internal static let Engineer: UIColor = hexStringToUIColor("#F7C62C")
  internal static let Science: UIColor = hexStringToUIColor("#6D8CFF")
  internal static let Tatical: UIColor = hexStringToUIColor("#F56756")
}

internal struct AppFonts {
  internal struct Roboto {
    internal static let FamilyName: String = "Roboto"
    internal static let Thin: String = "Roboto-Thin"
    internal static let Italic: String = "Roboto-Italic"
    internal static let BlackItalic: String = "Roboto-BlackItalic"
    internal static let Light: String = "Roboto-Light"
    internal static let BoldItalic: String = "Roboto-BoldItalic"
    internal static let Black: String = "Roboto-Black"
    internal static let LightItalic: String = "Roboto-LightItalic"
    internal static let ThinItalic: String = "Roboto-ThinItalic"
    internal static let Bold: String = "Roboto-Bold"
    internal static let Regular: String = "Roboto-Regular"
    internal static let Medium: String = "Roboto-Medium"
    internal static let MediumItalic: String = "Roboto-MediumItalic"
  }
  
  internal struct RobotoCondensed {
    internal static let FamilyName: String = "RobotoCondensed"
    internal static let Bold: String = "RobotoCondensed-Bold"
    internal static let Light: String = "RobotoCondensed-Light"
    internal static let BoldItalic: String = "RobotoCondensed-BoldItalic"
    internal static let Italic: String = "RobotoCondensed-Italic"
    internal static let Regular: String = "RobotoCondensed-Regular"
    internal static let LightItalic: String = "RobotoCondensed-LightItalic"
  }
}
