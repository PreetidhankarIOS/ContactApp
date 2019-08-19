//
//  Contact.swift
//  ContactApp
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

//A model to hold the data of contact
struct Contact {
    
    var id: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var profilePic: String = ""
    var isFavourite: Bool = false
    var url: String = ""
    var email: String = ""
    var phoneNumber: String  = ""
    var createdAt: String = ""
    var updatedAt: String = ""
    
    //returns the contatc's profile pic by adding the server url
    var profileUrlPath: String {
        return "\(EndPoint.BASE_URL.rawValue)\(profilePic)"
    }
    
    //returns the contatc's full name
    var fullName: String {
        if firstName.isEmpty {
            return lastName
        }
        else {
            return "\(firstName) \(lastName)"
        }
    }
    
    //a dict that will be used when the contact is being add/update
    var dictToSave: JsonDictionary{
        return ["first_name": self.firstName, "last_name": self.lastName, "email": self.email, "phone_number": self.phoneNumber]
    }
    
    init(json: JsonDictionary) {
        if let obj = json["id"] {
            self.id = "\(obj)".toInt ?? 0
        }
        
        if let obj = json["first_name"] {
            self.firstName = "\(obj)"
        }
        
        if let obj = json["last_name"] {
            self.lastName = "\(obj)"
        }
        
        if let obj = json["profile_pic"] {
            self.profilePic = "\(obj)"
        }
        
        if let obj = json["favorite"] {
            self.isFavourite = "\(obj)".toBool
        }
        
        if let obj = json["url"] {
            self.url = "\(obj)"
        }
        
        // below properties used for Contact Detail
        if let obj = json["email"] {
            self.email = "\(obj)".isEmpty ? LocalizedStrings.Dash.localized : "\(obj)"
        }
        
        if let obj = json["phone_number"] {
            self.phoneNumber = "\(obj)".isEmpty ? LocalizedStrings.Dash.localized : "\(obj)"
        }
        
        if let obj = json["created_at"] {
            self.createdAt = "\(obj)"
        }
        
        if let obj = json["updated_at"] {
            self.updatedAt = "\(obj)"
        }
    }
    
    static func getModels(json: [JsonDictionary]) -> [Contact] {
        return json.map { Contact(json: $0) }
    }
}
