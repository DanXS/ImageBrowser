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
        weak var expectation = self.expectation(description: "Get public Flickr feed")
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
                XCTAssertNotNil(item.title, "Flickr Item Model has no title field")
                XCTAssertNotNil(item.description, "Flickr Item Model has no description field")
                XCTAssertNotNil(item.tags, "Flickr Item Model has no tags field")
                XCTAssertNotNil(item.author, "Flickr Item Model has no author field")
                XCTAssertNotNil(item.authorId, "Flickr Item Model has no author id field")
                XCTAssertNotNil(item.dateTaken, "Flickr Item Model has no date taken field")
                XCTAssertNotNil(item.published, "Flickr Item Model has no published field")
                XCTAssertNotNil(item.link, "Flickr Item Model has no link field")
                XCTAssertNotNil(item.media, "Flickr Item Model has no media field")
                // Assuming the item loaded, lets check the media field
                guard item.media != nil else {
                    return
                }
                XCTAssertNotNil(item.media!.m, "Flickr Media Model has no m field")
            }
            expectation?.fulfill()
            expectation = nil
        })
        self.waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error, error!.localizedDescription)
        }
    }
    
    func testUtils() {
        XCTAssertNil(Util.toURL(string : nil), "URL should be nil if string paramateter is nil")
        XCTAssertNotNil(Util.toURL(string : "http://www.google.com"), "URL should be nil if string paramateter is nil")
        XCTAssertNil(Util.toDate(string : nil), "Date should be nil if string parameter is nil")
        XCTAssertNotNil(Util.toDate(string : "2017-09-21T08:45:37Z"), "This should be a valid Date/Time object")
    }
    
    func testImageViewModel() {
        weak var expectation = self.expectation(description: "Get public Flickr feed and map items to imageViewModel")
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
            XCTAssert(model.items.count > 0, "Flickr feed has no items")
            // Assuming we have items in the flickr feed, check each item for valid fields
            guard model.items.count > 0 else {
                return
            }
            let imageViewModels = model.items.map({ (item : FlickrItemModel) -> ImageViewModel in
                return ImageViewModel().fromFlickrItemModel(item: item)
            })
            for item in imageViewModels {
                XCTAssertNotNil(item.title, "Image View Model title is not set")
                XCTAssertNotNil(item.imageURL, "Image View Model image URL is not set")
            }
            expectation?.fulfill()
            expectation = nil
        })
        self.waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error, error!.localizedDescription)
        }
    }
    
    func testLoadImage() {
        weak var expectation = self.expectation(description: "Load a sample image from Flickr")
        guard let url = URL(string: "https://farm5.staticflickr.com/4369/36519305614_2641ca0c69_m.jpg") else {
            XCTFail("Invalid URL")
            return
        }
        Util.loadImage(url: url) { (image, response, error) in
            expectation?.fulfill()
            expectation = nil
        }
        self.waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error, error!.localizedDescription)
        }
    }
    
}
