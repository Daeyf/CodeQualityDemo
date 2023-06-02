//
//  AllImageViewModel.swift
//  CatAPI
//
//  Created by David Thierbach on 31.05.23.
//

import SwiftUI
import PromiseKit
import Logging

class AllImageViewModel: ObservableObject, BaseImageProtocol {
    
    /// list of images shown connected to the ui.
    @Published var catImageList: [Image] = []
    
    init() {
        loadCatPictures(with: 50)
    }
    
    /// Loads and fills the randomCatImage by calling the NetworkService using Promises
    func loadCatPictures(with listLimit: Int) {
        
        NetworkService.shared.loadCatApiPromise(with: listLimit)
            .thenMap { catApiInfo in
                return NetworkService.shared.loadPicture(with: catApiInfo.url)
            }
            .done { imageList in
                self.catImageList = imageList.compactMap({ uiImage in
                    Image(uiImage: uiImage)
                })
            }
            .catch { error in
                Log.shared.error("\(error.localizedDescription)")
            }
            .finally {
                Log.shared.info("Finished picture change successfully ✅")
            }
    }
}
