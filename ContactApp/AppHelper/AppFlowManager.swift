//
//  AppFlowManager.swift
//  ContactApp
//
//  Created by Pawan Kumar on 18/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit


/**********************************
 
 A singleton class for manage the navigation flow throughout the application
 
 ***********************************/

class AppFlowManager {
    static let `default` = AppFlowManager()
    private init() { }
    
    var mainNavigationController: UINavigationController? {
        return AppDelegate.shared.window?.rootViewController as? UINavigationController
    }
}


//Contact flow
extension AppFlowManager {
    
    func moveToContactDetailVC(contactId: Int) {
        let obj = ContactDetailVC.instantiate(fromAppStoryboard: .Contact)
        obj.viewModel.contactId = contactId
        self.mainNavigationController?.pushViewController(obj, animated: true)
    }
    
}



