//: Playground - noun: a place where people can play

import UIKit

if let filePathString: String = Bundle.main.path(forResource: "yabbling", ofType: "lua") {
  
  do {
    // 1. load data from file
    let fileData: Data = try Data(referencing: NSData(contentsOfFile: filePathString))
    
    // 2. convert to string
    if let dataAsString = String(data: fileData, encoding: .utf8) {
      var formattedJson: [String : AnyObject] = [:]
      
      // 3. attempt to remove all spaces
      dataAsString.replacingOccurrences(of: " ", with: "")
      
      // 4. iterrate over a mutable copy of each line
      for var component in dataAsString.components(separatedBy: "\n") {

        // 5. get index of the "=" which delimits value from key
        if let firstSpace = component.characters.index(of: "=") {
          
          // 6. wraps key in quotes to be proper json String
          let firstWord = "\"" + String(component.characters.prefix(upTo: firstSpace)).trimmingCharacters(in: CharacterSet.whitespaces) + "\""
          
          // 7. Get the index of the character following the "="
          let indexFollowingEquals = component.index(after: firstSpace)
          
          // 8. get the remaining substring
          var remainingSubstring = String(component.characters.suffix(from: indexFollowingEquals)).trimmingCharacters(in: CharacterSet.whitespaces)
          // 9. get following first character, ideally an " but can also be alphanumeric or {
          let firstCharacterFollowingEquals = remainingSubstring.characters.first
          
          // 10. this case means that the value is likely a bool or integer, wrap in quotes for now
          if firstCharacterFollowingEquals != "\"" && firstCharacterFollowingEquals != "{" {
            // 10a. get string to end of component
            remainingSubstring = "\"" + remainingSubstring + "\""
          }
          else if firstCharacterFollowingEquals == "{" {
            // 11. this case means an open bracket has been found, so we need to go through that as well
            
          }
          
          // 12. key/value pair has been found, reconstruct the component for further processing
          formattedJson[firstWord] = remainingSubstring as AnyObject
        }
      }
      print(formattedJson)
      
      // 13. verify valid json
      if JSONSerialization.isValidJSONObject(formattedJson) {
        print("so valid")
      }
      else {
        print("you could have done better")
      }
      
      // Next steps: either work with data as is and move on, or
      // save json-formatted data via Realm for data storage, or
      // create a plist/.json from said data to use internally in the app and this method only is ever run once on the raw data for initial conversion from game files. I guess ideally, once this is done once then the results can be uploaded somewhere and downloaded onto client machines to keep the DB updated
    }
  }
  catch {
    print("threw")
  }
  
}
else {
  print("nope")
}


let name = "Marie Curie"
if let firstSpace = name.characters.index(of: " ") {
  let firstName = String(name.characters.prefix(upTo: firstSpace))
  print(firstName)
}
else {
  print("nope")
}

// Prints "Marie"
