//
//  FlickrImageViewProvider.swift
//  ImageBrowser
//
//  Created by Dan Shepherd on 21/09/2017.
//  Copyright © 2017 Dan Shepherd. All rights reserved.
//

import Foundation

class FlickrImageViewProvider : ImageViewProvider {
    
    override func loadImageList() {
        FlickrAPI().getPublicFeed { (json, response, error) in
            if let json = json {
                let model = FlickrModel(json : json)
                let imageList = model.items.map({ (item : FlickrItemModel) -> ImageViewModel in
                    return ImageViewModel().fromFlickrItemModel(item: item)
                })
                self.delegate?.imageListLoadComplete(imageList: imageList)
            }
            else {
                self.delegate?.imageListLoadError(error: error)
            }
        }
    }
}
