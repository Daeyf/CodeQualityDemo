//
//  BrokenPromise.swift
//  CatAPI
//
//  Created by David Thierbach on 31.05.23.
//

import Foundation
import PromiseKit

/// Basehelper for General Promise fails
/// - Parameter method: issue can be inserted if needed on the output
/// - Returns: rejected Promise
func brokenPromise<T>(method: String = #function) -> Promise<T> {
  return Promise<T>() { seal in
    let err = NSError(domain: "CatApiNot", code: 0, userInfo: [NSLocalizedDescriptionKey: "'\(method)' not yet implemented."])
    seal.reject(err)
  }
}

/// Basehelper for UIImage Promise fails
/// - Returns: rejected Promise
func brokenUIImagePromise<UIImage>() -> Promise<UIImage> {
    return Promise<UIImage>() { seal in
          let err = NSError(domain: "CatApiNot", code: 0, userInfo: [NSLocalizedDescriptionKey: "Cannot load image"])
          seal.reject(err)
    }
}
