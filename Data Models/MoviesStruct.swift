//
//  MoviesStruct.swift
//  Movies
//
//  Created by Omar on 11/15/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct Movies: Identifiable, Codable, Hashable {
    
    var id: UUID
    var title: String
    var posterFileName: String
    var overview: String
    var genres: String
    var releaseDate: String
    var runtime: Int
    var director: String
    var actors: String
    var mpaaRating: String
    var imdbRating: String
    var youTubeTrailerId: String
    var tmdbID: Double
}

struct Star: Hashable, Codable, Identifiable {
   
    var id: UUID        
    var name: String
    var character: String
    var image: String
}
