//
//  CatAPITests.swift
//  CatAPITests
//
//  Created by David Thierbach on 31.05.23.
//

import XCTest
import PromiseKit
@testable import CatAPI

final class CatAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Test the loading function
    func testLoadCatApi() throws {
        // Create testable Expectation to fullfill
        let expectation = self.expectation(description: "CatApi")
        
        // Using the loading service
        var catApiInfoList: [CatApiInfo] = []
        CatAPI.NetworkService.shared.loadCatApiPromise(with: 1)
            .done { catApiList in
                catApiInfoList = catApiList
                Log.shared.info("Result: List is empty? \(catApiInfoList.isEmpty)")
                //Check if outcome is correct
                XCTAssertTrue(!catApiInfoList.isEmpty)
            }.catch { error in
                Log.shared.info("Loading test for CatApiInfo failed ❌")
            }.finally {
                //fulfill the expectation
                expectation.fulfill()
                Log.shared.info("Loading test for CatApiInfo was successful ✅")
            }
        
        // Since this is async we need some time to check if this is correct and doesn't end too early
        waitForExpectations(timeout: 300) { error in
            XCTAssertNil(error)
        }
    }
    
    func testLoadPictures() throws {
        
        // Create testable Expectation to fullfill when Image is loaded
        let expectation = self.expectation(description: "Picture")
        
        CatAPI.NetworkService.shared.loadCatApiPromise(with: 2)
            .thenMap { catApiInfo in
                return CatAPI.NetworkService.shared.loadPicture(with: catApiInfo.url)
            }
            .done { imageList in
                let compactList = imageList.compactMap { $0 }
                XCTAssertTrue(!compactList.isEmpty)
            }.catch { error in
                Log.shared.error("\(error.localizedDescription)")
            }
            .finally {
                Log.shared.info("Finished picture change successfully ✅")
                expectation.fulfill()
            }
        
        
        waitForExpectations(timeout: 300) { error in
            XCTAssertNil(error)
        }
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
