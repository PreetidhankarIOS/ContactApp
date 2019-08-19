//
//  LocalizedStrings.swift
//  ContactApp
//
//  Created by Pawan Kumar on 18/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation

enum LocalizedStrings: String {
    
    var localized: String {
        return self.rawValue.localized
    }
    
    case Contact
    case Dash
    case Group
    case noData
    case tryAgain
    case Message
    case Call
    case Email
    case Favourite
    case Success
    case OK
    case Error
    case Edit
    case Mobile
    case FirstName
    case LastName
    case typehere
    case DELETE
    case GotIt
    case Done
    case Save
    case Confirmation
    case Yes
    case No
    case ChooseFromOptions
    case ToSelectImage
    case PhotoLibrary
    case Camera
   
    
    
    //error messages
    case ContactUpdated
    case FirstNameIsBlank
    case LastNameIsBlank
    case PhoneIsBlank
    case EmailIsBlank
    case PhoneIsInValid
    case EmailIsInValid
    case AreYouSureToDelete
}
