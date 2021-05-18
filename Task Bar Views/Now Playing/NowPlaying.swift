//
//  NowPlaying.swift
//  Movies
//
//  Created by Omar on 11/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct NowPlaying: View {
    @EnvironmentObject var userData: UserData
  var body: some View {
      NavigationView {
          List {
              // Each movie struct has its own unique 'id' used by ForEach
              ForEach(nowPlayingList) { amovie in
                  NavigationLink(destination: NowPlayingDetails(movie: amovie)) {
                      FavoriteItem(movie: amovie)
                  }
              }
          }   // End of List
              .navigationBarTitle(Text("Movies Now Playing in Theatres"), displayMode: .inline)
      }   // End of NavigationView
  }
}
