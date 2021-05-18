//
//  MoviesData.swift
//  Movies
//
//  Created by Omar on 11/16/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import Foundation
import SwiftUI
 
// Global array of Movie structs
var movieStructList = [Movies]()
 
var orderedSearchableMovieList = [String]()

/*
 ******************************
 MARK: - Read Movie Data File
 ******************************
 */
public func readMovieDataFile() {
    var documentDirectoryHasFiles = false

   
    let movieDataFilename = "MoviesData.json"
   
    // Obtain URL of the ContactssData.json file in document directory on the user's device
    // Global constant documentDirectory is defined in UtilityFunctions.swift
    let urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(movieDataFilename)
 
    do {
        /*
         Try to get the contents of the file. The left hand side is
         suppressed by using '_' since we do not use it at this time.
         Our purpose is just to check to see if the file is there or not.
         */
 
        _ = try Data(contentsOf: urlOfJsonFileInDocumentDirectory)
       
        /*
         If 'try' is successful, it means that the CocktailsData.json
         file exists in document directory on the user's device.
         ---
         If 'try' is unsuccessful, it throws an exception and
         executes the code under 'catch' below.
         */
       
        documentDirectoryHasFiles = true
       
        /*
         --------------------------------------------------
         |   The app is being launched after first time   |
         --------------------------------------------------
         The CocktailsData.json file exists in document directory on the user's device.
         Load it from Document Directory into contactStructList.
         */
       
        // The function is given in UtilityFunctions.swift
        movieStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: movieDataFilename, fileLocation: "Document Directory")
        print("MoviesData is loaded from document directory")
        
        for movie in movieStructList {
            let selectedContactsAttributesForSearch = "\(movie.id)|\(movie.title)|\(movie.overview)|\(movie.genres)|\(movie.releaseDate)|\(movie.director)|\(movie.actors)|\(movie.mpaaRating)"

            orderedSearchableMovieList.append(selectedContactsAttributesForSearch)

        }
       
    } catch {
        documentDirectoryHasFiles = false
       
        /*
         ----------------------------------------------------
         |   The app is being launched for the first time   |
         ----------------------------------------------------
         The ContactsData.json file does not exist in document directory on the user's device.
         Load it from main bundle (project folder) into cocktailStructList.
        
         This catch section will be executed only once when the app is launched for the first time
         since we write and read the files in document directory on the user's device after first use.
         */
       
        // The function is given in UtilityFunctions.swift
        movieStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: movieDataFilename, fileLocation: "Main Bundle")
        print("MoviesData is loaded from main bundle")
       
        /*
         -------------------------------------------------------------
         |   Create global variable orderedSearchableContactsList   |
         -------------------------------------------------------------
         This list has two purposes:
        
            (1) preserve the order of countries according to user's liking, and
            (2) enable search of selected cocktail attributes by the SearchBar in FavoritesList.
        
        */
        for movie in movieStructList {
            let selectedContactsAttributesForSearch = "\(movie.id)|\(movie.title)|\(movie.overview)|\(movie.genres)|\(movie.releaseDate)|\(movie.director)|\(movie.actors)|\(movie.mpaaRating)"
           
            orderedSearchableMovieList.append(selectedContactsAttributesForSearch)
        }
       
    }   // End of do-catch
   

}
/*
 *****************************************************
 MARK: - Write Movie Data File to Document Directory
 *****************************************************
 */
public func writeMovieDataFile() {
 
    // Obtain the URL of the JSON file in the document directory on the user's device
    let urlOfJsonFileInDocumentDirectory: URL? = documentDirectory.appendingPathComponent("MoviesData.json")
 
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(movieStructList) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory!)
        } catch {
            fatalError("Unable to write encoded Movie data to document directory!")
        }
    } else {
        fatalError("Unable to encode Movie data!")
    }
    
    print("TEst")
}
public func getImageFromUrl(url: String, defaultFilename: String) -> Image {
    /*
     If getting image from URL fails, Image file with given defaultFilename
     (e.g., "ImageUnavailable") in Assets.xcassets will be returned.
     */
    var imageObtainedFromUrl = Image(defaultFilename)
 
    let headers = [
        "accept": "image/jpg, image/jpeg, image/png",
        "cache-control": "cache",
        "connection": "keep-alive",
    ]
 
    // Convert given URL string into URL struct
    guard let imageUrl = URL(string: url) else {
        return Image(defaultFilename)
    }
 
    let request = NSMutableURLRequest(url: imageUrl,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 30.0)
 
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
 
    /*
     Create a semaphore to control getting and processing image data.
     signal() -> Int    Signals (increments) a semaphore.
     wait()             Waits for, or decrements, a semaphore.
     */
    let semaphore = DispatchSemaphore(value: 0)
 
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        /*
        URLSession is established and the image file from the URL is set to be fetched
        in an asynchronous manner. After the file is fetched, data, response, error
        are returned as the input parameter values of this Completion Handler Closure.
        */
 
        // Process input parameter 'error'
        guard error == nil else {
            semaphore.signal()
            return
        }
 
        // Process input parameter 'response'. HTTP response status codes from 200 to 299 indicate success.
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            semaphore.signal()
            return
        }
 
        // Unwrap Optional 'data' to see if it has a value
        guard let imageDataFromUrl = data else {
            semaphore.signal()
            return
        }
 
        // Convert fetched imageDataFromUrl into UIImage object
        let uiImage = UIImage(data: imageDataFromUrl)
 
        // Unwrap Optional uiImage to see if it has a value
        if let imageObtained = uiImage {
            // UIImage is successfully obtained. Convert it to SwiftUI Image.
            imageObtainedFromUrl = Image(uiImage: imageObtained)
        }
 
        semaphore.signal()
    }).resume()
 
    /*
     The URLSession task above is set up. It begins in a suspended state.
     The resume() method starts processing the task in an execution thread.
 
     The semaphore.wait blocks the execution thread and starts waiting.
     Upon completion of the task, the Completion Handler code is executed.
     The waiting ends when .signal() fires or timeout period of 30 seconds expires.
    */
 
    _ = semaphore.wait(timeout: .now() + 30)
 
    return imageObtainedFromUrl
}
 

