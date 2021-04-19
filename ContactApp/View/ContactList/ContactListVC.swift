//
//  ContactListVC.swift
//  ContactApp
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

class ContactListVC: BaseVC {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var contactListTableView: GJTableView!
    
    // MARK: - Properties
    // MARK: - Public
    
    let viewModel = ContactListVM()
    
    // MARK: - Private
    //used when there is no data
    
    private lazy var noResultemptyView: EmptyScreenView = {
        let newEmptyView = EmptyScreenView()
        newEmptyView.vType = .noDataFound
        newEmptyView.delegate = self
        return newEmptyView
    }()
    
    // MARK: - Life Cycle
    
    override func initialSetup() {
        self.contactListTableView.dataSource = self
        self.contactListTableView.delegate = self
        self.contactListTableView.sectionIndexColor = AppColors.sectionIndex
        self.contactListTableView.backgroundView = self.noResultemptyView
        contactListTableView.backgroundView?.isHidden = true
        self.registerXib()
        self.viewModel.fetchContacts()
        
        NotificationCenter.default.addObserver(self, selector: #selector(contactDetailsChanged(_:)), name: .contactDetailsChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(contactDeleted(_:)), name: .contactDeleted, object: nil)
    }
    
    override func bindViewModel() {
        self.viewModel.delegate = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func setupNavBar() {
        //setting up the custom navigation view
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: LocalizedStrings.Group.localized, style: .plain, target: self, action: #selector(self.groupButtonTapped))
        self.navigationController?.navigationBar.tintColor = AppColors.themeGreen
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: AppColors.themeText,
             NSAttributedString.Key.font: AppFonts.SemiBold.withSize(17.0)]
        title = LocalizedStrings.Contact.localized
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonTapped))
    }
    
    
    // MARK: - Helper methods
    // MARK: - Action
    
    @objc func groupButtonTapped() {
        printDebug("group Button Tapped")
    }
    
    @objc func addButtonTapped() {
        printDebug("Add Button Tapped")
        AppFlowManager.default.moveToAddContactVC()
    }
    
    // MARK: - Private
    
    private func reloadList() {
        //hide/show the backgorund view if data is there or not
        contactListTableView.backgroundView?.isHidden = !self.viewModel.sections.isEmpty
        contactListTableView.reloadData()
    }
    
    private func registerXib() {
        self.contactListTableView.registerCell(nibName: ContactListTableViewCell.reusableIdentifier)
    }
    
    //as the contact deleted it'll be called bia notification
    @objc private func contactDeleted(_ note: Notification) {
        
        //logic to delete the contact that has been changed
        if let obj = note.object as? Contact {
            let firstChar = "\(obj.firstName.firstCharacter)".uppercased()
            if let sectionIdx = self.viewModel.sections.firstIndex(where: { $0.letter.uppercased() == firstChar }) {
                //if section is there with the first char of the name
                var section = self.viewModel.sections.remove(at: sectionIdx)
                
                if let row = section.contacts.firstIndex(where: { $0.id == obj.id }) {
                    //if found the contact with the changed one delete it
                    var oldData = section.contacts
                    oldData.remove(at: row)
                    
                    if !oldData.isEmpty {
                        section.contacts = oldData
                        self.viewModel.sections.insert(section, at: sectionIdx)
                    }
                }
            }
        }
        reloadList()
    }
    
    //as the contact details changed it'll be called bia notification
    @objc private func contactDetailsChanged(_ note: Notification) {
        if let obj = note.object as? Contact {
            //logic to add/update the contact that has been changed
            let firstChar = "\(obj.firstName.firstCharacter)".uppercased()
            if let sectionIdx = self.viewModel.sections.firstIndex(where: { $0.letter.uppercased() == firstChar }) {
                //if section is there with the first char of the name
                var section = self.viewModel.sections.remove(at: sectionIdx)
                
                if let row = section.contacts.firstIndex(where: { $0.id == obj.id }) {
                    //if found the contact with the changed one update it
                    var oldData = section.contacts
                    oldData.remove(at: row)
                    oldData.insert(obj, at: row)
                    
                    section.contacts = oldData
                }
                else {
                    //if not found the contact with the changed one add as new one
                    section.contacts.append(obj)
                }
                
                self.viewModel.sections.insert(section, at: sectionIdx)
            }
            else {
                //if section is not there with the first char of the name
                let sec = Section(letter: firstChar, contacts: [obj])
                self.viewModel.sections.append(sec)
                self.viewModel.sections.sort { $0.letter < $1.letter }
            }
        }
        reloadList()
    }
}

// MARK: - ContactListVM Delegate methods

extension ContactListVC: ContactListVMDelegate {
    func willFetchContacts() {
        AppGlobals.shared.startLoading()
    }
    
    func fetchContactsSuccess() {
        AppGlobals.shared.stopLoading()
        self.viewModel.createSectionWiseDataForContacts()
        self.reloadList()
    }
    
    func fetchContactsFail() {
        AppGlobals.shared.stopLoading()
    }
}

// MARK: - Empty screen view delegate methods

extension ContactListVC: EmptyScreenViewDelegate {
    func firstButtonAction(sender: UIButton) {
        self.viewModel.fetchContacts()
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate methods

extension ContactListVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sections.count
    }
    
    // Return section Index For titles
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.viewModel.sections.map { $0.letter }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.sections[section].letter
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.sections[section].contacts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.contactListTableView.dequeueReusableCell(withIdentifier: ContactListTableViewCell.reusableIdentifier, for: indexPath) as? ContactListTableViewCell else {
            fatalError("ContactListTableViewCell not found")
        }
        let section = self.viewModel.sections[indexPath.section]
        cell.contact = section.contacts[indexPath.row]
        cell.dividerView.isHidden = (section.contacts.count == (indexPath.row + 1))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           AppFlowManager.default.moveToContactDetailVC(contactId: self.viewModel.sections[indexPath.section].contacts[indexPath.row].id)
    }
}
