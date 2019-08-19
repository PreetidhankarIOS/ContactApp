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
}
