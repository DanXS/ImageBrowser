//
//  FlickrModel.swift
//  ImageBrowser
//
//  Created by Dan Shepherd on 21/09/2017.
//  Copyright © 2017 Dan Shepherd. All rights reserved.
//

import Foundation

class FlickrModel {
    
    var title : String?
    var description : String?
    var link : URL?
    var modified : Date?
    
    init(json : [String : Any?]) {
        self.title = json["title"] as? String
        self.description = json["description"] as? String
        
        
    }
}
