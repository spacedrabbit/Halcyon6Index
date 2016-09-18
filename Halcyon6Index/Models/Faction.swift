//
//  Faction.swift
//  Halcyon6Index
//
//  Created by Louis Tur on 9/18/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
/*
 name  = "chruul"
 full_name = "Chruul"
 color = "#E6444D"
 icon  = "Icons/faction_chruul"
 description = "chruul"
 fleet_travel_time = 32400

 name  = "possessed_korzan"
 full_name = "The Chruul"
 color = "#E6444D"
 icon  = "Icons/faction_korzan"
 description = "korzan"
 
 name  = "collective"
 full_name = "Collective"
 color = "#FADC5F"
 icon  = "Icons/faction_collective"
 home_sector = "Tranzensis"
 description = "collective"
 
 name  = "terran_delivery"
 full_name = "The Federation"
 color = "#00000000"
 icon  = "Icons/faction_terran"
 home_sector = "New Terra"
 player_controlled = false
 resources = { crew = 750 }
 description = "terran"
 */

extension String {
  internal mutating func airQuotes() {
    self = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    self = "\"" + self + "\""
  }
}

internal class DataLoader {
  
  internal class func loadFactionData() {
    if let filePathString: String = Bundle.main.path(forResource: "yabbling", ofType: "lua") {
      
      do {
        let fileData: Data = try Data(referencing: NSData(contentsOfFile: filePathString))
        if let dataAsString = String(data: fileData, encoding: .utf8) {
          
          
          let components: [String] = dataAsString.components(separatedBy: "\n")
          for com in components {
            let subcomponents: [String] = com.components(separatedBy: "=")
            for var sub in subcomponents {
              if !sub.hasPrefix("\"") && !sub.hasSuffix("\"") {
                sub.airQuotes()
              }
            }
          }

          /*
          // this will work to separate out into an array of components which can be iterrated to find values based on keys
          let cleanedString = dataAsString.replacingOccurrences(of: "=", with: ":")
          let components = cleanedString.components(separatedBy: "\n")
          
          // at this point we could further subcomponent each string by grabbing the elements before and after the : and making sure they are in quotes
          let formatted = "{\n" + components.joined(separator: ",\n") + "\n}"
          print("json? \(formatted)")
          
          if JSONSerialization.isValidJSONObject(formatted) {
            print("looks valid")
          }
          else {
            print("not valid")
          }
//          let json: Data = try JSONSerialization.data(withJSONObject: formatted, options: [])
          
          
          */
        }
      }
      catch {
        print("it threw")
      }
    }
  }
  
}

// Data/Streaming Assets/mdi_baseline.h6module/factions
internal struct FactionKeys {
  internal static let name: String = "name"
  internal static let full_name: String = "full_name"
  internal static let color: String = "color"
  internal static let description: String = "description"
  internal static let fleet_travel_time: String = "fleet_travel_time"
  internal static let icon: String = "icon"
  internal static let home_sector: String = "home_sector"
  internal static let resources: String = "resources"
  internal static let player_controlled: String = "player_controlled"
}

internal struct Faction {
  internal let name: String
  internal let fullName: String
  internal let color: String
  internal let icon: String
  internal let descriptopn: String
  
  internal var homeSector: String?
  internal var fleetTravelTime: Int?
  internal var playerController: Bool?
  internal var resourcesCrew: Int?
}
