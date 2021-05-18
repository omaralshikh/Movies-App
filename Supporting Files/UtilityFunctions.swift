//
//  UtilityFunctions.swift
//  NationalPark
//
//  Created by Omar on 11/11/20.
//

import Foundation
import SwiftUI
 
// Global constant
let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
 
/*
*************************************************
MARK: - Decode JSON file into an Array of Structs
*************************************************
*/
public func decodeJsonFileIntoArrayOfStructs<T: Decodable>(fullFilename: String, fileLocation: String, as type: T.Type = T.self) -> T {
  
    /*
     T.self defines the struct type T into which each JSON object will be decoded.
        exampleStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: "exampleFile.json", fileLocation: "Main Bundle")
     or
        exampleStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: "exampleFile.json", fileLocation: "Document Directory")
     The left hand side of the equation defines the struct type T into which JSON objects will be decoded.
   
     This function returns an array of structs of type T representing the JSON objects in the input JSON file.
     In Swift, an Array stores values of the same type in an ordered list. Therefore, the structs will keep their order.
     */
  
    var jsonFileData: Data?
    var jsonFileUrl: URL?
    var arrayOfStructs: T?
  
    if fileLocation == "Main Bundle" {
        // Obtain URL of the JSON file in main bundle
        let urlOfJsonFileInMainBundle: URL? = Bundle.main.url(forResource: fullFilename, withExtension: nil)
      
        if let mainBundleUrl = urlOfJsonFileInMainBundle {
            jsonFileUrl = mainBundleUrl
        } else {
            print("JSON file \(fullFilename) does not exist in main bundle!")
        }
    } else {
        // Obtain URL of the JSON file in document directory on user's device
        let urlOfJsonFileInDocumentDirectory: URL? = documentDirectory.appendingPathComponent(fullFilename)
      
        if let docDirectoryUrl = urlOfJsonFileInDocumentDirectory {
            jsonFileUrl = docDirectoryUrl
        } else {
            print("JSON file \(fullFilename) does not exist in document directory!")
        }
    }
  
    do {
        jsonFileData = try Data(contentsOf: jsonFileUrl!)
    } catch {
        print("Unable to obtain JSON file \(fullFilename) content!")
    }
  
    do {
        // Instantiate an object from the JSONDecoder class
        let decoder = JSONDecoder()
      
        // Use the decoder object to decode JSON objects into an array of structs of type T
        arrayOfStructs = try decoder.decode(T.self, from: jsonFileData!)
    } catch {
        print("Unable to decode JSON file \(fullFilename)!")
    }
  
    // Return the array of structs of type T
    return arrayOfStructs!
}
 
