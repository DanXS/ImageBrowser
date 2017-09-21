//
//  FlickrItemModel.swift
//  ImageBrowser
//
//  Created by Dan Shepherd on 21/09/2017.
//  Copyright © 2017 Dan Shepherd. All rights reserved.
//

import Foundation

class FlickrItemModel {
    var title : String?
    var description : String?
    var tags : String?
    var author : String?
    var authorId : String?
    var dateTaken : Date?
    var published : Date?
    var link : URL?
    
    
    init(json : [String : Any?]) {
        self.title = json["title"] as? String
        self.description = json["description"] as? String
        self.tags = json["tags"] as? String
        self.author = json["author"] as? String
        self.authorId = json["author_id"] as? String
        self.dateTaken = Util.toDate(string: json["date_taken"] as? String)
        self.published = Util.toDate(string: json["published"] as? String)
        self.link = Util.toURL(string: json["link"] as? String)
    }
}
