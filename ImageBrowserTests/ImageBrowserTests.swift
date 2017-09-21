//
//  ImageBrowserTests.swift
//  ImageBrowserTests
//
//  Created by Dan Shepherd on 19/09/2017.
//  Copyright © 2017 Dan Shepherd. All rights reserved.
//

import XCTest
@testable import ImageBrowser

class ImageBrowserTests: XCTestCase {
    
    var flickrAPI : FlickrAPI?
    
    override func setUp() {
        super.setUp()
        self.flickrAPI = FlickrAPI()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFlickrPublicFeed() {
        let expectation = self.expectation(description: "Get public Flickr feed")
        self.flickrAPI?.getPublicFeed(completion: { (json, response, error) in
            XCTAssert(error == nil, error!.localizedDescription)
            XCTAssert(response != nil, "Nil response object from Flickr feed")
            if let httpResponse = response as? HTTPURLResponse {
                XCTAssert(httpResponse.statusCode == 200, "Response status code should be 200 - i.e success")
            }
            XCTAssert(json != nil, "No result from public Flickr feed")
            print("\(json!)")
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 10) { (error) in
            XCTAssert(error == nil, error!.localizedDescription)
        }
    }
    
}
