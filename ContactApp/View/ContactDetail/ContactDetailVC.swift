//
//  ContactDetailVC.swift
//  ContactApp
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailVC: BaseVC {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var contactDetailTableView: GJTableView!
    
    // MARK: - Properties
    
    // MARK: -
    
    var contactDetailHeaderView = ContactDetailHeaderView()
    let viewModel = ContactDetailVM()
    
    // MARK: - Life cycle
    override func initialSetup() {
        self.contactDetailHeaderView = ContactDetailHeaderView.instanceFromNib()
        self.contactDetailTableView.tableHeaderView = contactDetailHeaderView
        self.contactDetailTableView.dataSource = self
        self.contactDetailTableView.delegate = self
        self.registerXib()
        self.viewModel.fetchContactDetail()
        
        NotificationCenter.default.addObserver(self, selector: #selector(contactDetailsChanged(_:)), name: .contactDetailsChanged, object: nil)
    }
    
    override func setupNavBar() {
        //setting up the custom navigation view
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = AppColors.themeGreen
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: LocalizedStrings.Edit.localized, style: .plain, target: self, action: #selector(self.editButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = AppColors.themeGreen
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    override func bindViewModel() {
        self.viewModel.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        guard let headerView = contactDetailTableView.tableHeaderView else {
            return
        }
        
        headerView.frame.size = CGSize(width: UIDevice.screenWidth, height: 315.0)
        self.contactDetailTableView.tableHeaderView = headerView
        self.contactDetailTableView.layoutIfNeeded()
    }
    
    func configureHeaderView() {
        self.contactDetailHeaderView.contactDetail = self.viewModel.contactDetail
    }
    
    private func registerXib() {
        self.contactDetailTableView.registerCell(nibName: ContactDetailTableViewCell.reusableIdentifier)
    }
    
    @objc func editButtonTapped() {
    }
    
    private func reloadData() {
        contactDetailTableView.reloadData()
        configureHeaderView()
    }
    
    //method that will call when the `contactDetailsChanged` notification will be posted to the notification center
    //will refresh the list by adding/changing the new/updated contact without calling  the API
    @objc private func contactDetailsChanged(_ note: Notification) {
        if let obj = note.object as? Contact {
            self.viewModel.contactDetail = obj
            self.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource And UITableViewDelegate methods

extension ContactDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.contactDetailTableView.dequeueReusableCell(withIdentifier: ContactDetailTableViewCell.reusableIdentifier) as? ContactDetailTableViewCell else {
            fatalError("ContactDetailTableViewCell not found")
        }
        
        guard let contact = self.viewModel.contactDetail else {
            printDebug("contact not found")
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            cell.configureCell(title: LocalizedStrings.Mobile.localized, isEditingEnabled: false, inputText: contact.phoneNumber)
        } else {
            cell.configureCell(title: LocalizedStrings.Email.localized, isEditingEnabled: false, inputText: contact.email)
        }
        
        return cell
    }
}

// MARK: - ContactDetailVM Delegate methods

extension ContactDetailVC: ContactDetailVMDelgate {
    func willFetchContactDetail() {
        //
    }
    
    func fetchContactDetailSuccess() {
        self.contactDetailTableView.reloadData()
        self.configureHeaderView()
    }
    
    func fetchContactDetailFail(errorMessage: String) {
        // Hanle error cases
        printDebug(errorMessage)
    }
}
