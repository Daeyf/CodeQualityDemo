//
//  AllImageView.swift
//  CatAPI
//
//  Created by David Thierbach on 31.05.23.
//

import SwiftUI

struct AllImageView: View {
    
    /// Shared Object for interaction in between view and viewmodel
    @ObservedObject var imageViewModel = AllImageViewModel()
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: twoColumnGrid) {
                ForEach(0..<imageViewModel.catImageList.count, id: \.self) { imageID in
                    imageViewModel.catImageList[imageID]
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}

struct AllImageView_Previews: PreviewProvider {
    static var previews: some View {
        AllImageView()
    }
}
