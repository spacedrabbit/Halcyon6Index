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
  
  internal func hasAirQuotes() -> Bool {
    if self.hasPrefix("\"") && self.hasSuffix("\"") {
      return true
    }
    return false
  }
}

internal enum DataLoadingError: Error {
  case DataLoaderFailedLoadingContentsOfFile
  case DataLoaderCouldNotFindFile
}


internal typealias JSON = [String : AnyObject]
internal class DataLoader {
  
  /**
   Takes a parameter of `String` that corresponds to the file name to parse. Expects `String` in the form of "filename.extension"
   - parameters: `file` is the name of the file whose contents should be converted to `Data`
   - returns: On success, `Data` representation of the file contents. `throws` if either the file cannot be found or on error loading file contents as `Data`. Returns `nil` if the filename is not in the correct form.
   */
  internal class func loadData(from file: String) throws -> Data? {
    
    let components: [String] = file.components(separatedBy: ".")
    guard
      let fileName: String = components.first,
      let fileExtension: String = components.last
    else { return nil }
    
    if let filePathString: String = Bundle.main.path(forResource: fileName, ofType: fileExtension) {
      do {
        return try Data(referencing: NSData(contentsOfFile: filePathString))
      }
      catch {
        throw DataLoadingError.DataLoaderFailedLoadingContentsOfFile
      }
    }
    throw DataLoadingError.DataLoaderCouldNotFindFile
  }
  
  internal class func convert(data: Data) -> String? {
    if let dataAsString = String(data: data, encoding: .utf8) {
      let whiteSpaceClearedString = dataAsString.replacingOccurrences(of: " ", with: "")
      return whiteSpaceClearedString
    }
    return nil
  }
  
  // TODO: do not remove all spaces, must be done on a per-component basis
  // TODO: remove quotes, everywhere. 
  internal class func parseIntoJson(string: String) -> JSON {
    var formattedJson: [String : AnyObject] = [:]
    
    for var component in string.components(separatedBy: "\n") {
      if let indexOfEqualSign = component.characters.index(of: "=") {
        let indexFollowingEqualSign = component.index(after: indexOfEqualSign)
        
        let key: String = String(component.characters.prefix(upTo: indexOfEqualSign))
        var remainingSubstring = String(component.characters.suffix(from: indexFollowingEqualSign))
        let firstCharacterFollowingEquals = remainingSubstring.characters.first
        
        if firstCharacterFollowingEquals != "\"" && firstCharacterFollowingEquals != "{" {
//          remainingSubstring = "\"" + remainingSubstring + "\""
        }
        else if firstCharacterFollowingEquals == "{" {
          // this case means an open bracket has been found, so we need to go through that as well
          
          // the below is not correct! at this point we need to itterate over the components to find the one with the 
          // closing bracket, then merge those together as a String separated by \n's, THEN send them back into this function
          return DataLoader.parseIntoJson(string: remainingSubstring.trimmingCharacters(in: CharacterSet(charactersIn: "{}")))
        }
        
        // 12. key/value pair has been found, reconstruct the component for further processing
        formattedJson[key] = remainingSubstring.trimmingCharacters(in: CharacterSet.init(charactersIn: "\"")) as AnyObject
      }
    }
    return formattedJson
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
  internal var fleetTravelTime: String? //Int
  internal var playerControlled: String? //Bool
  internal var resourcesCrew: String? //Int
  
  internal var description: String {
    return "Faction of \(self.fullName)"
  }
  
  internal init?(from json: JSON) {
    guard
      let name: String = json[FactionKeys.name] as? String,
      let fullName: String = json[FactionKeys.full_name] as? String,
      let color: String = json[FactionKeys.color] as? String,
      let icon: String = json[FactionKeys.icon] as? String,
      let description: String = json[FactionKeys.description] as? String
    else {
      return nil
    }
    
    self.name = name
    self.fullName = fullName
    self.color = color
    self.icon = icon
    self.descriptopn = description
    
    self.homeSector = json[FactionKeys.home_sector] as? String
    self.fleetTravelTime = json[FactionKeys.fleet_travel_time] as? String
    self.playerControlled = json[FactionKeys.player_controlled] as? String
    self.resourcesCrew = json[FactionKeys.resources] as? String
  }
}
