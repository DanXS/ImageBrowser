//
//  ImageViewProvider.swift
//  ImageBrowser
//
//  Created by Dan Shepherd on 21/09/2017.
//  Copyright © 2017 Dan Shepherd. All rights reserved.
//

import Foundation

protocol ImageViewProviderDelegate {
    func imageListLoadComplete(imageList : [ImageViewModel])
    func imageListLoadError(error : Error?)
}

class ImageViewProvider {
    
    let delegate : ImageViewProviderDelegate!
    
    init(delegate : ImageViewProviderDelegate) {
        self.delegate = delegate
    }
    
    func loadImageList() {
        self.delegate?.imageListLoadComplete(imageList: [])
    }
    
}
