//
//  ProgressViewStyle.swift
//  NationalPark
//
//  Created by Omar on 11/11/20.
//

import SwiftUI
 
struct DarkBlueShadowProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .shadow(color: Color(red: 0, green: 0, blue: 0.6),
                    radius: 4.0, x: 1.0, y: 2.0)
    }
}
 
