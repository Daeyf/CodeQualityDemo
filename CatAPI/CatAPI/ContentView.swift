//
//  ContentView.swift
//  CatAPI
//
//  Created by David Thierbach on 31.05.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            RandomImageView().tabItem {
                VStack {
                    Image(systemName: "square.and.arrow.down.fill")
                        .renderingMode(.template)
                        .resizable()
                    Text("Random")
                }
            }.tag(0)
            
            AllImageView().tabItem {
                VStack {
                    Image(systemName: "globe")
                        .renderingMode(.template)
                        .resizable()
                    Text("All")
                }
            }.tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
