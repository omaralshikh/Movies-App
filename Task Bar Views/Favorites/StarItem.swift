//
//  StarItem.swift
//  Movies
//
//  Created by Omar on 11/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct StarItem: View {
    
    let star: Star
   
    var body: some View {
        HStack {
            getImageFromUrl(url: "http://image.tmdb.org/t/p/w500/\(star.image)", defaultFilename: "ImageUnavailable")
                .resizable()
                .frame(width: 70, height: 105)
            VStack(alignment: .leading){
                Text(star.name)
                Text("playing")
                Text(star.character)
            }
        }
            .font(.system(size: 14))   
    }
   
}
