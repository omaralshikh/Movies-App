//
//  MovieSearchDetails.swift
//  Movies
//
//  Created by Omar on 11/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct MovieSearchDetails: View {
    @EnvironmentObject var userData: UserData
  var body: some View {

          List {
              // Each movie struct has its own unique 'id' used by ForEach
              ForEach(searchMoviesList) { amovie in
                  NavigationLink(destination: NowPlayingDetails(movie: amovie)) {
                      FavoriteItem(movie: amovie)
                  }
              }
          }   // End of List
              .navigationBarTitle(Text("Found Movies"), displayMode: .inline)

  }
}
