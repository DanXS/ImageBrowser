//
//  FlickrMediaModel.swift
//  ImageBrowser
//
//  Created by Dan Shepherd on 21/09/2017.
//  Copyright © 2017 Dan Shepherd. All rights reserved.
//

import Foundation

class FlickrMediaModel {
    
    var m : URL?
    
    init(json : [String : Any?]) {
        self.m = Util.toURL(string: json["m"] as? String)
    }
}
