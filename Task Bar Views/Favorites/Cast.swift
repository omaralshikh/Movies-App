//
//  Cast.swift
//  Movies
//
//  Created by Omar on 11/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct Cast: View {
    var body: some View {

            List {
                // Each movie struct has its own unique 'id' used by ForEach
                ForEach(foundStarsList) { astar in
                    StarItem(star: astar)

               
            }   // End of List
        }
    }
}
