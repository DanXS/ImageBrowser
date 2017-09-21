//
//  Util.swift
//  ImageBrowser
//
//  Created by Dan Shepherd on 21/09/2017.
//  Copyright © 2017 Dan Shepherd. All rights reserved.
//

import UIKit

class Util {
    static func toURL(string : String?) -> URL? {
        guard string != nil else {
            return nil
        }
        return URL(string : string!)
    }
    
    static func toDate(string : String?) -> Date? {
        guard string != nil else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: string!)
    }
    
    static func loadImage(url : URL, completion: @escaping (_ : UIImage?, _ : URLResponse?, _ : Error?) -> ()) {
        let task = URLSession.shared.dataTask(with : url) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 && data != nil && error == nil {
                    let image = UIImage(data: data!)
                    completion(image, response, error)
                    return
                }
            }
            completion(nil, response, error)
        }
        task.resume()
    }
}
