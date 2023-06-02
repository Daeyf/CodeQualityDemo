//
//  RandomImageViewModel.swift
//  CatAPI
//
//  Created by David Thierbach on 31.05.23.
//

import SwiftUI
import PromiseKit
import Logging

class RandomImageViewModel: ObservableObject, BaseImageProtocol {
    
    /// image shown connected to the ui.
    @Published var randomCatImage: Image = Image("placeholder")
    
    init() {
        loadCatPictures(with: 1)
    }
    
    /// Loads and fills the randomCatImage by calling the NetworkService using Promises
    func loadCatPictures(with listLimit: Int) {
        NetworkService.shared.loadCatApiPromise(with: listLimit)
            .then {catApiLoadedList -> Promise<UIImage> in
                return self.prepareModelForPicture(with: catApiLoadedList)
            }
            .done { image in
                self.exchangeCatImage(with: image)
            }
            .catch { error in
                Log.shared.error("\(error.localizedDescription)")
            }
            .finally {
                Log.shared.info("Finished picture change successfully ✅")
            }
    }
    
    /// Create Request for the picture with the link inside the CatAPIInfo
    /// - Parameter catApiInfoList: List of CatApiInfo where only the first element is used
    /// - Returns: Promise with the needed Image
    func prepareModelForPicture(with catApiInfoList: [CatApiInfo]) -> Promise<UIImage> {
            guard let firstCat = catApiInfoList.first else {
                Log.shared.error("No Cat listed!")
                return brokenUIImagePromise()
            }
            return NetworkService.shared.loadPicture(with: firstCat.url)
    }
    
    /// Load the image in the UIView, since the global image is Published
    /// - Parameter uiImage: image of a cat
    func exchangeCatImage(with uiImage: UIImage){
            self.randomCatImage = Image(uiImage: uiImage)
    }
}
