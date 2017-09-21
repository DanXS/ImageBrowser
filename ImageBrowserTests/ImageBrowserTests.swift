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
            guard json != nil else {
                return
            }
            let model = FlickrModel(json : json!)
            XCTAssertNotNil(model.title, "Flickr Model has no title field")
            XCTAssertNotNil(model.description, "Flickr Model has no description field")
            XCTAssertNotNil(model.link, "Flickr Model has no link field")
            XCTAssertNotNil(model.modified, "Flickr Model has no modified date time field")
            XCTAssert(model.items.count > 0, "Flickr feed has no items")
            // Assuming we have items in the flickr feed, check each item for valid fields
            guard model.items.count > 0 else {
                return
            }
            for item in model.items {
                XCTAssertNotNil(item.title, "Fickr Item Model has no title field")
                XCTAssertNotNil(item.description, "Fickr Item Model has no description field")
                XCTAssertNotNil(item.tags, "Fickr Item Model has no tags field")
                XCTAssertNotNil(item.author, "Fickr Item Model has no author field")
                XCTAssertNotNil(item.authorId, "Fickr Item Model has no author id field")
                XCTAssertNotNil(item.dateTaken, "Fickr Item Model has no date taken field")
                XCTAssertNotNil(item.published, "Fickr Item Model has no published field")
                XCTAssertNotNil(item.link, "Fickr Item Model has no link field")
            }
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 10) { (error) in
            XCTAssert(error == nil, error!.localizedDescription)
        }
    }
    
    func testUtils() {
        XCTAssertNil(Util.toURL(string : nil), "URL should be nil if string paramateter is nil")
        XCTAssertNotNil(Util.toURL(string : "http://www.google.com"), "URL should be nil if string paramateter is nil")
        XCTAssertNil(Util.toDate(string : nil), "Date should be nil if string parameter is nil")
        XCTAssertNotNil(Util.toDate(string : "2017-09-21T08:45:37Z"), "This should be a valid Date/Time object")
        
    }
    
}
