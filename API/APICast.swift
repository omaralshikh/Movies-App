//
//  APICast.swift
//  Movies
//
//  Created by Omar on 11/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import Foundation
import SwiftUI

// Global array of Star structs
var foundStarsList = [Star]()


/*
 -----------------------------------------------------
 MARK: - Get Stars Data from API for the Given Query
 -----------------------------------------------------
 */
public func getStarsDataFromApi(apiQueryUrl: String) {
    
    // Clear out previous content in the global array
    foundStarsList = [Star]()
    
    
    
        let jsonDataFromApi = getJsonDataFromApi(apiUrl: "https://api.themoviedb.org/3/movie/\(apiQueryUrl)?api_key=9130acef02325a467bb2808b39e5e341&append_to_response=credits")

        //------------------------------------------------
        // JSON data is obtained from the API. Process it.
        //------------------------------------------------
        do {
            /*
             Foundation framework’s JSONSerialization class is used to convert JSON data
             into Swift data types such as Dictionary, Array, String, Number, or Bool.
             */
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                                                                options: JSONSerialization.ReadingOptions.mutableContainers)
            
            //------------------------------------------
            // Obtain Top Level JSON Object (Dictionary)
            //------------------------------------------
            var topLevelDictionary = Dictionary<String, Any>()
            
            if let jsonObject = jsonResponse as? [String: Any] {
                topLevelDictionary = jsonObject
            } else {
        
                // foundStarsList will be empty
                return
            }
            
            //------------------------------------
            // Obtain Array of "hits" JSON Objects
            //------------------------------------
            var bottomLevelDictionary = Dictionary<String, Any>()
            
            if let jsonObject2 = topLevelDictionary["credits"] as? [String : Any] {
               bottomLevelDictionary = jsonObject2
            } else {
         
                // foundStarsList will be empty
                return
            }
            
            
            var arrayOfHitsJsonObjects = Array<Any>()
            
            if let jsonArray = bottomLevelDictionary["cast"] as? [Any] {
                arrayOfHitsJsonObjects = jsonArray
            } else {
              
                // foundStarsList will be empty
                return
                
                
            }
            for index in 0..<arrayOfHitsJsonObjects.count {
                
                //-------------------------
                // Obtain Star Dictionary
                //-------------------------
                var starDictionary = Dictionary<String, Any>()
                
                if let jsonDictionary = arrayOfHitsJsonObjects[index] as? [String: Any] {
                    
                    starDictionary = jsonDictionary
                    }
               else {
        
                    // foundStarsList will be empty
                    return
                }
                
                //----------------
                // Initializations
                //----------------
                
                var starName = "", starImageURL = "", charName = ""
                
                //-------------------
                // Obtain Star Name
                //-------------------
                
                /*
                 IF starDictionary["label"] has a value AND the value is of type String THEN
                 unwrap the value and assign it to local variable starName
                 ELSE leave starName as set to ""
                 */
                if let nameOfStar = starDictionary["name"] as! String? {
                    starName = nameOfStar
                }
                
                //------------------------
                // Obtain Star Image URL
                //------------------------
                
                /*
                 IF starDictionary["image"] has a value AND the value is of type String THEN
                 unwrap the value and assign it to local variable starImageURL
                 ELSE leave starImageURL as set to ""
                 */

                
                
                
                
                    if let imageURL = starDictionary["profile_path"] as? String
                    {
                        starImageURL = imageURL
                    }
                    else {
                        starImageURL = ""
                    }
                
                
                
                //--------------------------
                // Obtain Star Source Name
                //--------------------------
                
                /*
                 IF starDictionary["source"] has a value AND the value is of type String THEN
                 unwrap the value and assign it to local variable sourceName
                 ELSE leave sourceName as set to ""
                 */
                if let nameOfChar = starDictionary["character"] as! String? {
                    charName = nameOfChar
                }
                

                
                //-------------------------------
                // Obtain Star Ingredient Lines
                //-------------------------------
                

  
                //*************************************************************
                // Construct a New Star Struct and Add it to foundStarsList
                //*************************************************************
                
                let foundStar = Star(id: UUID(), name: starName, character: charName, image: starImageURL)
                
                foundStarsList.append(foundStar)
                
            }   // End of the for loop
            
        } catch {

            return
        }
        
    
    }
    



