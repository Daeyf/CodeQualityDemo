//
//  CatApiInfo.swift
//  CatAPI
//
//  Created by David Thierbach on 31.05.23.
//

import Foundation

struct CatApiInfo: Codable {
    let id: String?
    let width: Int?
    let height: Int?
    let url: String
    let breeds: [BreedsInfo]?
    let categories: [CategoryType]?
}
