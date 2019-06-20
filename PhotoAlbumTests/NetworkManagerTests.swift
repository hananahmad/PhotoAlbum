//
//  NetworkManagerTests.swift
//  PhotoAlbumTests
//
//  Created by Hanan on 6/20/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import XCTest

class NetworkManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchAlbumOperation() {
        
        let expect = expectation(description: "Networking service executed well.")
        
        NetworkManager.requestForType(serviceType: ServiceType.serviceLoadAlbums, params: nil) { (response, error) in
            if let _ = error {
                XCTFail("Failure in fetching albums api.")
            }else if let _ = response {
                
            }
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
