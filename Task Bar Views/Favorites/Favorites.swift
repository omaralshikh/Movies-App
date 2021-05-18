//
//  Favorites.swift
//  Movies
//
//  Created by Omar on 11/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct Favorites: View {
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    @State private var searchItem = ""

    var body: some View {
        NavigationView {
            List {
                SearchBar(searchItem: $searchItem, placeholder: "Search Movies")
                // Each movie struct has its own unique 'id' used by ForEach
                ForEach(userData.searchableOrderedMovieList.filter {self.searchItem.isEmpty ? true : $0.localizedStandardContains(self.searchItem)}, id: \.self)
                { amovie in
                    
                    NavigationLink(destination: FavoriteDetails(movie: self.searchMovie(searchListItem: amovie)))
                    {
                        
                        FavoriteItem(movie: self.searchMovie(searchListItem: amovie))
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
               
            }   // End of List
            .navigationBarTitle(Text("Favorites"), displayMode: .inline)
           
            // Place the Edit button on left of the navigation bar
            .navigationBarItems(leading: EditButton())
           
        }   // End of NavigationView
    }
    
    func searchMovie(searchListItem: String) -> Movies {
        
        // Find the index number of cocktailList matching the cocktail attribute 'id'
        let index = userData.moviesList.firstIndex(where: {$0.id.uuidString == searchListItem.components(separatedBy: "|")[0]})!
       
        return userData.moviesList[index]
    }

   
    /*
     -------------------------------
     MARK: - Delete Selected movie
     -------------------------------
     */
    /*
     IndexSet:  A collection of unique integer values that represent the indexes of elements in another collection.
     first:     The first integer in self, or nil if self is empty.
     */
    func delete(at offsets: IndexSet) {
        /*
         'offsets.first' is an unsafe pointer to the index number of the array element
         to be deleted. It is nil if the array is empty. Process it as an optional.
         */
        if let index = offsets.first {
           
            let nameOfFileToDelete = userData.moviesList[index].posterFileName

            
           
            // Obtain the document directory file path of the file to be deleted
            let filePath = documentDirectory.appendingPathComponent(nameOfFileToDelete).path
           
            do {
                let fileManager = FileManager.default
               
                // Check if the photo file exists in document directory
                if fileManager.fileExists(atPath: filePath) {
                    // Delete the photo file from document directory
                    try fileManager.removeItem(atPath: filePath)
                } else {
                    // Photo file does not exist in document directory
                }
            } catch {
                print("Unable to delete the photo file from the document directory.")
            }
           
            // Remove the selected photo from the list
            userData.moviesList.remove(at: index)
            userData.searchableOrderedMovieList.remove(at: index)
           
            // Set the global variable point to the changed list
            movieStructList = userData.moviesList
            orderedSearchableMovieList = userData.searchableOrderedMovieList

        }
    }
    /*
     -----------------------------
     MARK: - Move Selected movie
     -----------------------------
     */
    func move(from source: IndexSet, to destination: Int) {
 
        userData.moviesList.move(fromOffsets: source, toOffset: destination)
        userData.searchableOrderedMovieList.move(fromOffsets: source, toOffset: destination)

       
        // Set the global variable point to the changed list
        movieStructList = userData.moviesList
        orderedSearchableMovieList = userData.searchableOrderedMovieList

    }
}
