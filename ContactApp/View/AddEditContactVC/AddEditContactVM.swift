//
//  AddEditContactVM.swift
//  ContactApp
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

protocol AddEditContactVMDelegate: class {
    func willUpdateContact()
    func updateContactSuccess()
    func updateContactFail()
    func willAddContact()
    func addContactSuccess()
    func addContactFail()
    
    func deleteContactSuccess()
}

class AddEditContactVM {
    enum UsingFor {
        case add
        case edit
    }
    
    // MARK: - Properties
    
    // MARK: - Public
    
    weak var delegate: AddEditContactVMDelegate?
    
    var contact: Contact?
    var selectedImage: UIImage?
    var usingFor: UsingFor = .add
    
    private var isVerified: Bool {
        var flag: Bool = true
        var errorMessage = ""
        if (self.contact?.firstName ?? "").isEmpty {
            errorMessage = LocalizedStrings.FirstNameIsBlank.localized
            flag = false
        }
        else if (self.contact?.lastName ?? "").isEmpty {
            errorMessage = LocalizedStrings.LastNameIsBlank.localized
            flag = false
        }
        else if (self.contact?.phoneNumber ?? "").isEmpty {
            errorMessage = LocalizedStrings.PhoneIsBlank.localized
            flag = false
        }
        else if !(self.contact?.phoneNumber ?? "").isPhoneNumber {
            errorMessage = LocalizedStrings.PhoneIsInValid.localized
            flag = false
        }
        else if (self.contact?.email ?? "").isEmpty {
            errorMessage = LocalizedStrings.EmailIsBlank.localized
            flag = false
        }
        else if !(self.contact?.email ?? "").isEmail {
            errorMessage = LocalizedStrings.EmailIsInValid.localized
            flag = false
        }
        
        if !flag {
            AppGlobals.shared.showAlert(title: LocalizedStrings.Error.localized, message: errorMessage, buttonTitle: LocalizedStrings.GotIt.localized, onCompletion: nil)
        }
        
        return flag
    }
    
    // Add Contact Api
    func addContactAPI() {
        guard self.isVerified else {
            return
        }
        
        APICaller.shared.callAddContatAPI(params: self.contact?.dictToSave ?? [:]) { [weak self] success, _, contact in
            guard let sSelf = self else { return }
            sSelf.delegate?.willAddContact()
            if success, let obj = contact {
                NotificationCenter.default.post(name: .contactDetailsChanged, object: obj)
                sSelf.delegate?.addContactSuccess()
            }
            else {
                sSelf.delegate?.addContactFail()
            }
        }
    }
    
    // Update Contact Api
    func updateContactAPI() {
        guard self.isVerified else {
            return
        }
        
        self.delegate?.willUpdateContact()
        APICaller.shared.callUpateContactDetailAPI(contactId: self.contact?.id ?? 0, params: self.contact?.dictToSave ?? [:]) { [weak self] success, _, contact in
            guard let sSelf = self else { return }
            if success, let obj = contact {
                NotificationCenter.default.post(name: .contactDetailsChanged, object: obj)
                sSelf.delegate?.updateContactSuccess()
            }
            else {
                sSelf.delegate?.updateContactSuccess()
            }
        }
    }
    
    // Delete Contact Api
    func deleteContactAPI() {
        guard let con = self.contact else { return }
        
        APICaller.shared.deleteContactAPI(forId: con.id) { [weak self] success, error in
            guard let sSelf = self else { return }
            
            AppGlobals.shared.showAlert(title: LocalizedStrings.Success.localized, message: error, buttonTitle: LocalizedStrings.OK.localized, onCompletion: {
                if success {
                    NotificationCenter.default.post(name: .contactDeleted, object: con)
                    sSelf.delegate?.deleteContactSuccess()
                }
            })
        }
    }
}
