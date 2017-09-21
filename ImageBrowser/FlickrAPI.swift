//
//  FlickrAPI.swift
//  ImageBrowser
//
//  Created by Dan Shepherd on 19/09/2017.
//  Copyright © 2017 Dan Shepherd. All rights reserved.
//

import Foundation

class FlickrAPI {
    
    func getPublicFeed(completion : @escaping (_ : Any?, _ : URLResponse?, _ : Error?) -> ()) {
        guard let url = URL(string:"https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1") else {
            completion(nil, nil, nil)
            return
        }
        let task = URLSession.shared.dataTask(with : url) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 && data != nil && error == nil {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        completion(json, response, error)
                    }
                    catch let error {
                        completion(nil, response, error)
                    }
                    return
                }
            }
            completion(nil, response, error)
        }
        task.resume()
    }
    
}
