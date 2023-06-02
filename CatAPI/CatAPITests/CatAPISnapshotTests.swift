//
//  CatAPISnapshotTests.swift
//  CatAPITests
//
//  Created by David Thierbach on 01.06.23.
//
import XCTest
import SnapshotTesting
import SwiftUI
@testable import CatAPI

class SnapshotsTests: XCTestCase {
    
    var imageList: [Image] = []
    
    override func setUpWithError() throws {
        
        imageList = [Image("Cat1"), Image("Cat2"), Image("Cat3")]
        
        isRecording = false
    }

    func testDefaultAppearance() {
        let contentView = ContentView()
        
        assertSnapshot(matching: contentView.toVC(), as: .image(on: .iPhoneX))
    }
    
    func testRandomItemAppearance() {
        let contentView = RandomImageView()
        contentView.imageViewModel.randomCatImage = imageList.first ?? Image("placeholder")
        
        assertSnapshot(matching: contentView.toVC(), as: .image(on: .iPhoneX))
    }
    
    func testAllItemsAppearance() {
        let contentView = AllImageView()
        contentView.imageViewModel.catImageList = imageList
        
        assertSnapshot(matching: contentView.toVC(), as: .image(on: .iPhoneX))
    }

}

extension SwiftUI.View {
    func toVC() -> UIViewController {
        let vc = UIHostingController(rootView: self)
        vc.view.frame = UIScreen.main.bounds
        return vc
    }
}
