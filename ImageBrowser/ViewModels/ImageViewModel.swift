//
//  ImageViewModel.swift
//  ImageBrowser
//
//  Created by Dan Shepherd on 21/09/2017.
//  Copyright © 2017 Dan Shepherd. All rights reserved.
//

import UIKit

class ImageViewModel {
    var title : String?
    var image : UIImage?
    var imageURL : URL?
    
    init() {
        
    }
}

extension ImageViewModel {
    func fromFlickrItemModel(item : FlickrItemModel) -> ImageViewModel {
        self.title = item.title
        self.imageURL = item.media?.m
        return self
    }
}
