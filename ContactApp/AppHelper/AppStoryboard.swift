//
//  AppStoryboard.swift
//  ContactApp
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit




/**********************************
 
 An enum that will hold all the
 storyboards used in the app.
 
 Usages: Will help to instantiate the new controller without knowing the storyboard id
 
 ContactDetailVC.instantiate(fromAppStoryboard: .Contact)
 
 UIViewController must have the storyboard identifier same as the class name.
 
 ***********************************/

enum AppStoryboard: String {
    case Contact
}


extension AppStoryboard {
    
    var instance : UIStoryboard {
        
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func getStoryBoard(name:AppStoryboard) -> UIStoryboard {
        return UIStoryboard.init(name: name.rawValue, bundle: nil)
    }
    
    
    func viewController<T : UIViewController>(_ viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        
        return instance.instantiateInitialViewController()
    }
}



extension UIViewController {
    
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        
        return appStoryboard.viewController(self)
    }
}
