//
//  Genres.swift
//  Movies
//
//  Created by Omar on 11/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI
import Foundation

let movieGenresList = ["Action", "Adventure", "Animation", "Biography", "Comedy", "Crime", "Documentary", "Drama", "Family", "Fantasy", "Horror", "Music", "Mystery", "Romance", "Sci-Fi", "Suspense", "Thriller", "War", "Western"]
struct Genre: View {
    
    @EnvironmentObject var userData: UserData
    @State private var selectedGenre = movieGenresList[0]
    
    var body: some View {
        NavigationView{
            ZStack {
                // Color the background to light gray
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                VStack {
                    Divider()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(0 ..< movieGenresList.count, id: \.self) { aGenre in
                                Button(action: {
                                    self.selectedGenre = movieGenresList[aGenre]
                                }) {
                                    VStack {
                                        Image(movieGenresList[aGenre])
                                            
                                            .resizable()
                                            .frame(width: 70, height: 70)
                                        
                                        Text(movieGenresList[aGenre])
                                            .fixedSize()
                                            .foregroundColor(movieGenresList[aGenre] == self.selectedGenre ? .red : .blue)
                                            .multilineTextAlignment(.center)
                                    }
                                        
                                        .font(.system(size: 10))   // End of HStack
                                }  // End of Button
                                    .buttonStyle(PlainButtonStyle())
                            }
                        }   // End of ForEach
                        
                    }   // End of ScrollView
                        .frame(width: UIScreen.main.bounds.width - 20)
                        // Fixes ScrollView at its ideal size. Button names do not truncate.
                        .fixedSize()
                    
                    Divider()
                    
                    
                    List {
                        // Each movie struct has its own unique 'id' used by ForEach
                        ForEach(userData.moviesList) { amovie in
                            if(amovie.genres.contains(self.selectedGenre)){
                            NavigationLink(destination: FavoriteDetails(movie: amovie)) {
                                FavoriteItem(movie: amovie)
                                
                            }
                            }
                        }
                        
                        
                        
                        
                        
                    }   // End of NavigationView
                }
                
            }   // End of ZStack
                .navigationBarTitle(Text("Genre List Of Movies"), displayMode: .inline)
        }
        
        
        
    }
}
