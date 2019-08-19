//
//  ContactListVM.swift
//  ContactApp
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation
protocol ContactListVMDelegate: class {
    func willFetchContacts()
    func fetchContactsSuccess()
    func fetchContactsFail()
}

class ContactListVM {
    
    // MARK: - Properties
    
    // MARK: - Public
    
    weak var delegate: ContactListVMDelegate?
    var contacts: [Contact] = []
    // section array  for Making header wise list
    var sections = [Section]()
    
    //logic to create the sectionwise data
    func createSectionWiseDataForContacts() {
        let groupedDictionary = Dictionary(grouping: self.contacts, by: { String($0.firstName.prefix(1)).capitalizedFirst() })
        let keys = groupedDictionary.keys.sorted()
        sections = keys.map { Section(letter: $0, contacts: groupedDictionary[$0]!.sorted(by: { (ct1, ct2) -> Bool in
            ct1.firstName.lowercased() < ct2.firstName.lowercased()
        })) }
    }
    
    //responsible to fetch all the contacts from server
    func fetchContacts() {
        delegate?.willFetchContacts()
        APICaller.shared.callGetAllContactAPI { [weak self] success, message, contacts in
            guard let sSelf = self else { return }
            if success {
                sSelf.contacts = contacts
                sSelf.delegate?.fetchContactsSuccess()
            }
            else {
                sSelf.delegate?.fetchContactsFail()
            }
        }
    }
}

// Structure for creating section wise data
struct Section {
    var letter: String
    var contacts: [Contact]
    
    init(letter: String, contacts: [Contact]) {
        self.letter = letter
        self.contacts = contacts
    }
}
