//
//  NowPlayingDetails.swift
//  Movies
//
//  Created by Omar on 11/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct NowPlayingDetails: View {
    // Input Parameter
    let movie: Movies
     @EnvironmentObject var userData: UserData
    
     @State private var showAddedMessage = false
   
    var body: some View {
        // A Form cannot have more than 10 Sections.
        // Group the Sections if more than 10.
        Form {
            Group {
                Section(header: Text("Movie Title")) {
                    Text(movie.title)
                }
                Section(header: Text("Movie Poster")) {
                 getImageFromUrl(url: "http://image.tmdb.org/t/p/w500/\(movie.posterFileName)", defaultFilename: "ImageUnavailable")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                Section(header: Text("Youtube movie Trailer")) {
                    NavigationLink(destination: WebView(url: "http://www.youtube.com/embed/\(movie.youTubeTrailerId)")
                                    .navigationBarTitle(Text("Play Movie Trailer"), displayMode: .inline)) {
                        HStack {
                                   Image(systemName: "play.rectangle.fill")
                                       .imageScale(.medium)
                                       .font(Font.title.weight(.regular))
                                       .foregroundColor(.red)
                                   Text("Play YouTube Movie Trailer Video")
                                       .font(.system(size: 16))
                                 
                               }
                               .frame(minWidth: 300, maxWidth: 500, alignment: .leading)
                           }
                           .navigationBarTitle(Text("YouTube Video"), displayMode: .inline)
                       }
                Section(header: Text("Movie Overview")) {
                    Text(movie.overview)
                }
                Section(header: Text("list Movie Cast Members")) {
                    NavigationLink(destination: StarsList) {
                        HStack{
                        Image(systemName: "rectangle.stack.person.crop")
                        .resizable()
                             .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                            Text("List Movie Cast Members")
                                .font(.system(size: 16))
                                
                        } // hstack
                    }
                } // section
                Section(header: Text("Add this Movie to My Movies list")) {
                                   Button(action: {
                                       // Append the country found to userData.countriesList
                                    self.userData.moviesList.append(self.movie)
                
                                       // Set the global variable point to the changed list
                                    movieStructList = self.userData.moviesList
                         
                                      let movieSearch = "\(movie.id)|\(movie.title)|\(movie.overview)|\(movie.genres)|\(movie.releaseDate)|\(movie.director)|\(movie.actors)|\(movie.mpaaRating)"
                                    
                                    self.userData.searchableOrderedMovieList.append(movieSearch)
                                    
                                    orderedSearchableMovieList = self.userData.searchableOrderedMovieList
                                    
                                       self.showAddedMessage = true
                                   }) {
                                    HStack {
                                       Image(systemName: "plus")
                                           .imageScale(.medium)
                                           .font(Font.title.weight(.regular))
                                    Text("Add Movie to Favorites")
                                        .font(.system(size: 16))
                                    }
                                   }
                               }
            }
            Group {
                Section(header: Text("Movie Runtime")) {
                    Text("\(movie.runtime/60) hours \(movie.runtime%60) mins")
                }
                Section(header: Text("Movie Genres")) {
                    Text(movie.genres)
                }
                Section(header: Text("Movie Release Date")) {
                    Text(movie.releaseDate)
                }
                Section(header: Text("Movie Director")) {
                    Text(verbatim: movie.director)
                }
                Section(header: Text("Movie Top Actors")) {
                    Text(movie.actors)
                }
                Section(header: Text("Movie MPAA Rating")) {
                    Text(movie.mpaaRating)
                }
                Section(header: Text("Movie IMDb Rating")) {
                    Text(movie.imdbRating)
                }
            }
 
        }   // End of Form
            .navigationBarTitle(Text(movie.title), displayMode: .inline)
            .alert(isPresented: $showAddedMessage, content: { self.alert })
        .font(.system(size: 14))
    }

    var StarsList : some View{
        
        getStarsDataFromApi(apiQueryUrl: String(movie.tmdbID))
        return Cast()
    }
    
    var alert: Alert {
           Alert(title: Text("Movie Added!"),
                 message: Text("This movie is added to your My Movies list."),
                 dismissButton: .default(Text("OK")) )
       }

    
}
 
 
