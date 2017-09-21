//
//  Util.swift
//  ImageBrowser
//
//  Created by Dan Shepherd on 21/09/2017.
//  Copyright © 2017 Dan Shepherd. All rights reserved.
//

import Foundation

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
}
