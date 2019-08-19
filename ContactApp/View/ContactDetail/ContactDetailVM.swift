//
//  ContactDetailVM.swift
//  ContactApp
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation

protocol ContactDetailVMDelgate: class {
    func willFetchContactDetail()
    func fetchContactDetailSuccess()
    func fetchContactDetailFail(errorMessage: String)
}

class ContactDetailVM {

    // MARK: - Properties
    // MARK: - Public
    
    weak var delegate: ContactDetailVMDelgate?
    var contactDetail: Contact?
    var contactId: Int = 0

    func fetchContactDetail() {
        delegate?.willFetchContactDetail()
        APICaller.shared.callGetContactDetailAPI(contactId: contactId) { [weak self] success, message, contact in
            guard let sSelf = self else { return }
            if success {
                sSelf.contactDetail = contact
                printDebug(" Fetch Contacts Api Message: \(message)")
                sSelf.delegate?.fetchContactDetailSuccess()
            }
            else {
                printDebug(" Fetch Contacts Api Message: \(message)")
                sSelf.delegate?.fetchContactDetailFail(errorMessage: message)
            }
        }
    }
}
