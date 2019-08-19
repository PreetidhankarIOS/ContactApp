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

typealias JsonDictionary = [String: Any]



/**********************************
 
 Hold some important methods used in app
 
 ***********************************/
struct AppGlobals {
    static let shared = AppGlobals()
    private init() {}
    
    func startLoading(animatingView: UIView? = nil) {
        PKLoaderSettings.shared.indicatorColor = AppColors.themeGreen
        PKLoaderSettings.shared.indicatorType = .ballRotateChase
        PKLoader.shared.startAnimating(onView: animatingView)
    }
    
    func stopLoading() {
        PKLoader.shared.stopAnimating()
    }
    
    func showAlert(title:String, message: String , successButtonTitle:String, cancelButtonTitle:String , onCompletion completion: @escaping (Bool)->Void){
        
        let alertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
        let doneAction = UIAlertAction(title:successButtonTitle, style: .default) { (_) -> Void in
            completion(true)
        }
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .destructive) { (_) in
            completion(false)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(doneAction)
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil);
    }
    
    func showAlert(title:String, message: String , buttonTitle:String, onCompletion completion: (()->Void)?){
        
        let alertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
        let doneAction = UIAlertAction(title:buttonTitle, style: .cancel) { (_) -> Void in
            completion?()
        }
        alertController.addAction(doneAction)
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil);
    }
    
}


enum AppPlaceholder {
    static let profile = #imageLiteral(resourceName: "placeholder_photo")
}

/**********************************
 
 Used to broadcast the
 notification in the app
 
 ***********************************/

extension Notification.Name {
    static let contactDetailsChanged = Notification.Name("ContactDetailsChanged")
    static let contactDeleted = Notification.Name("contactDeleted")
}

