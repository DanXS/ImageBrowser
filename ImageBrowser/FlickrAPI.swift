//
//  FlickrAPI.swift
//  ImageBrowser
//
//  Created by Dan Shepherd on 19/09/2017.
//  Copyright © 2017 Dan Shepherd. All rights reserved.
//

import Foundation

class FlickrAPI {
    
    func getPublicFeed(completion : @escaping (_ : Data?, _ : URLResponse?, _ : Error?) -> ()) {
        guard let url = URL(string:"https://api.flickr.com/services/feeds/photos_public.gne?format=json") else {
            completion(nil, nil, nil)
            return
        }
        let task = URLSession.shared.dataTask(with : url) { (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
    
}
