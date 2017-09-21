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
    var items : [FlickrItemModel] = []
    
    init(json : [String : Any?]) {
        self.title = json["title"] as? String
        self.description = json["description"] as? String
        self.link = Util.toURL(string: json["link"] as? String)
        self.modified = Util.toDate(string: json["modified"] as? String)
        if let jsonItems = json["items"] as? [[String : Any?]] {
            self.items = jsonItems.map({ (item) -> FlickrItemModel in
                return FlickrItemModel(json : item)
            })
        }
    }
}
