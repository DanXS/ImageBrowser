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
            XCTAssertNil(error, error!.localizedDescription)
            XCTAssertNotNil(response, "Nil response object from Flickr feed")
            if let httpResponse = response as? HTTPURLResponse {
                XCTAssert(httpResponse.statusCode == 200, "Response status code should be 200 - i.e success")
            }
            XCTAssertNotNil(json, "No result from public Flickr feed")
            // Assuming we now have the correct json data, try to populate the model
            let model = FlickrModel(json : json!)
            XCTAssertNotNil(model.title, "Flickr Model has no title")
            XCTAssertNotNil(model.description, "Flickr Model has no description")
            XCTAssertNotNil(model.link, "Flickr Model has no link")
            XCTAssertNotNil(model.modified, "Flickr Model has no modified date time")
            
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 10) { (error) in
            XCTAssert(error == nil, error!.localizedDescription)
        }
    }
    
}
