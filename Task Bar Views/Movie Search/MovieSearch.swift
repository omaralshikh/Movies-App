//
//  MovieSearch.swift
//  Movies
//
//  Created by Omar on 11/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct MovieSearch: View {
    
     @State private var searchFieldValue = ""
     @State private var searchFieldEmpty = false
     @State private var searchCompleted = false
    
     var body: some View {
         NavigationView {
             Form {
                 Section(header:
                     Text("Enter movie title to search")
                         .padding(.top, 100)   // Put padding here to preserve form's background color
                 ) {
                     HStack {
                         TextField("Enter Search Query", text: $searchFieldValue)
                             .textFieldStyle(RoundedBorderTextFieldStyle())
                             .keyboardType(.default)
  
                             // Options: .allCharacters, .none, .sentences, .words
                            .autocapitalization(.words)
  
                             // Turn off auto correction
                             .disableAutocorrection(true)
                        
                         Button(action: {
                             self.searchFieldValue = ""
                             self.searchFieldEmpty = false
                             self.searchCompleted = false
                         }) {
                             Image(systemName: "multiply.circle")
                                 .imageScale(.medium)
                                 .font(Font.title.weight(.regular))
                         }
                     }   // End of HStack
                     .alert(isPresented: $searchFieldEmpty, content: { self.emptyAlert })
                 }
                 Section(header: Text("Search Movies")) {
                     HStack {
                         Button(action: {
                             // Remove spaces, if any, at the beginning and at the end of the entered search query string
                             let queryTrimmed = self.searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                             if (queryTrimmed.isEmpty) {
                                 self.searchFieldEmpty = true
                             } else {
                                 self.searchApi()
                                 self.searchCompleted = true
                             }
                         }) {
                             Text(self.searchCompleted ? "Search Completed" : "Search")
                         }
                         .frame(width: 240, height: 36, alignment: .center)
                         .background(
                             RoundedRectangle(cornerRadius: 16)
                                 .strokeBorder(Color.black, lineWidth: 1)
                         )
                     }   // End of HStack
                 }
                 if searchCompleted {
                     Section(header: Text("List Movies Found")) {
                         NavigationLink(destination: showSearchResults) {
                            HStack {
                                Image(systemName: "list.bullet")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                                    .foregroundColor(.blue)
                                Text("List Movies Found")
                                    .font(.system(size: 16))
                            }
                         }
                     }
                 }
  
             }   // End of Form
             .navigationBarTitle(Text("Search Movies"), displayMode: .inline)
           
         }   // End of NavigationView
     }   // End of body
    
     func searchApi() {
  
         // public func obtainCompanyDataFromApi is given in CompanyDataFromApi.swift
         let search = self.searchFieldValue.replacingOccurrences(of: " ", with: "+")
       
         searchMovies(apiQueryUrl: search)
     }
    
     var showSearchResults: some View {
        
        
         if (searchMoviesList.count == 0) {
             return AnyView(notFoundMessage)
         }
  
         return AnyView(MovieSearchDetails())
     }
    
     var emptyAlert: Alert {
         Alert(title: Text("Movie Search Field is Empty!"),
            message: Text("Please enter a Search Query!"),
            dismissButton: .default(Text("OK")))
     }
  
    var notFoundMessage: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .imageScale(.large)
                .font(Font.title.weight(.medium))
                .foregroundColor(.red)
                .padding()
            Text("No Movie Found!\n\nThe entered query \(self.searchFieldValue) under category \("Movie Name") did not return a movie from the API! Please enter another search query.")
                .fixedSize(horizontal: false, vertical: true)   // Allow lines to wrap around
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color(red: 1.0, green: 1.0, blue: 240/255))     // Ivory color
    }

    
 }
  
