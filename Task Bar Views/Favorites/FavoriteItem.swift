//
//  FavoriteItem.swift
//  Movies
//
//  Created by Omar on 11/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct FavoriteItem: View {
    // Input Parameter
    let movie: Movies
   
    var body: some View {
        HStack {
            getImageFromUrl(url: "http://image.tmdb.org/t/p/w500/\(movie.posterFileName)", defaultFilename: "ImageUnavailable")
            .resizable()
            .frame(width: 80, height: 105)
            VStack(alignment: .leading){
                Text(movie.title)
                HStack{
                    Image("IMDb")
                    .resizable()
                    .frame(width: 20, height: 20)
                    Text(movie.imdbRating)
                }
                Text(movie.actors)
                HStack{
                    Text(movie.mpaaRating)
                    Text("\(movie.runtime) mins")
                    Text(movie.releaseDate)
                }
            }
           
        }
            .font(.system(size: 14))   // End of HStack
    }
   
}
