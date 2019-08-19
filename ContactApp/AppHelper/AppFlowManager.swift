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


// MARK: - Pop Methods
extension AppFlowManager {
    func popViewController(animated: Bool) {
        self.mainNavigationController?.popViewController(animated: animated)
    }
    
    func popToViewController(_ viewController: UIViewController, animated: Bool) {
        self.mainNavigationController?.popToViewController(viewController, animated: animated)
    }
    
    func popToRootViewController(animated: Bool) {
        self.mainNavigationController?.popToRootViewController(animated: animated)
    }
}


//Contact flow
extension AppFlowManager {
    
    func moveToContactDetailVC(contactId: Int) {
        let obj = ContactDetailVC.instantiate(fromAppStoryboard: .Contact)
        obj.viewModel.contactId = contactId
        self.mainNavigationController?.pushViewController(obj, animated: true)
    }
    
    func moveToEditContactVC(contact: Contact?) {
        let obj = AddEditContactVC.instantiate(fromAppStoryboard: .Contact)
        obj.viewModel.contact = contact
        obj.viewModel.usingFor = .edit
        self.mainNavigationController?.pushViewController(obj, animated: true)
    }
    
    func moveToAddContactVC() {
        let obj = AddEditContactVC.instantiate(fromAppStoryboard: .Contact)
        obj.viewModel.contact = Contact(json: [:])
        obj.viewModel.usingFor = .add
        self.mainNavigationController?.pushViewController(obj, animated: true)
    }
    
}



