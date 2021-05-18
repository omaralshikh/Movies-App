//
//  ContentView.swift
//  Movies
//
//  Created by Omar on 11/15/20.
//


import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
         
           Favorites()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
           NowPlaying()
                .tabItem {
                    Image(systemName: "rectangle.stack.fill")
                    Text("Now Playing")
                }
            
            MovieSearch()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Movie Search")
                }
            Genre()
                .tabItem {
                    Image(systemName: "list.and.film")
                    Text("Genre")
                }
 
            
        }   // End of TabView
            .font(.headline)
            .imageScale(.medium)
            .font(Font.title.weight(.regular))
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserData())
    }
}
