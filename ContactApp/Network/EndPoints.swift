//
//  EndPoints.swift
//  ContactApp
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation

/**********************************
 
 An enum that will hold the all the
 end points of the server
 
 ***********************************/

enum EndPoint: String {
    
    // MARK: - Base URLs
    
    case BASE_URL = "http://gojek-contacts-app.herokuapp.com"
    
    case allContacts = "/contacts.json"
}

// MARK: - endpoint extension for url

extension EndPoint {
    var url: String {
        switch self {
        case .BASE_URL:
            return self.rawValue
        default:
            let tmpString = "\(EndPoint.BASE_URL.rawValue)\(self.rawValue)"
            return tmpString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        }
    }
}
