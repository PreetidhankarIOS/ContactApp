//
//  AppGlobals.swift
//  ContactApp
//
//  Created by Pawan Kumar on 18/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

/// ************  GLOBALS ************///
/// **********************************///

// a method that will be use in the app to print the logs
// comment this method all the logs will be off at once
func printDebug<T>(_ obj: T) {
    //    print(obj)
}



/**********************************
 
 Hold some important methods used in app
 
 ***********************************/
struct AppGlobals {
    static let shared = AppGlobals()
    private init() {}
    
}
