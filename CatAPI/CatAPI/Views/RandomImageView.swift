//
//  RandomImageView.swift
//  CatAPI
//
//  Created by David Thierbach on 31.05.23.
//

import SwiftUI

struct RandomImageView: View {
    
    /// Shared Object for interaction in between view and viewmodel
    @ObservedObject var imageViewModel = RandomImageViewModel()
    
    var body: some View {
        VStack {
            imageViewModel.randomCatImage
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button {
                imageViewModel.loadCatPictures(with: 1)
            } label: {
                Text("Load next: 🔄")
            }
            .buttonStyle(.bordered)

        }
    }
}

struct RandomImageView_Previews: PreviewProvider {
    static var previews: some View {
        RandomImageView()
    }
}
