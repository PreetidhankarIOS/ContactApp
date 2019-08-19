//
//  AddEditContactVC.swift
//  ContactApp
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

class AddEditContactVC: BaseVC {

    // MARK: - IBOutlet
    
    @IBOutlet var addEditTableView: GJTableView!
    
    // MARK: - Properties
    
    // MARK: -
    
    private let headerView: ContactAddEditHeaderView = ContactAddEditHeaderView.instanceFromNib()
    
    let viewModel = AddEditContactVM()
    
    // MARK: - View Life cycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let headerView = addEditTableView.tableHeaderView else {
            return
        }
        
        headerView.frame.size = CGSize(width: UIDevice.screenWidth, height: 200.0)
        self.addEditTableView.tableHeaderView = headerView
        self.addEditTableView.layoutIfNeeded()
    }
    
    // MARK: - Overrirde methods
    
    override func initialSetup() {
        self.addEditTableView.dataSource = self
        self.addEditTableView.delegate = self
        self.addEditTableView.tableHeaderView = headerView
        
        self.headerView.delegate = self
        
        self.registerXib()
        
        if self.viewModel.usingFor == .add {
            self.viewModel.contact = Contact(json: [:])
        }
        self.setHeaderData()
    }
    
    override func setupNavBar() {
        // setting up the custom navigation view
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelButtonTapped))
        self.navigationController?.navigationBar.tintColor = AppColors.themeGreen
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneButtonTapped))
    }
    
    // MARK: - Helper methods
    
    @objc func cancelButtonTapped() {
        AppFlowManager.default.popViewController(animated: true)
    }
    
    override func bindViewModel() {
        self.viewModel.delegate = self
    }
    
    @objc func doneButtonTapped() {
        if self.viewModel.usingFor == .add {
            self.viewModel.addContactAPI()
        }
        else {
            self.viewModel.updateContactAPI()
        }
    }
    
    private func setHeaderData() {
        if let img = self.viewModel.selectedImage {
            self.headerView.profileImageView.image = img
        }
        else {
            self.headerView.profileImageView.setImage(from: self.viewModel.contact?.profileUrlPath ?? "", placeHolder: AppPlaceholder.profile, contentMode: .scaleAspectFill)
        }
    }
    
    private func registerXib() {
        self.addEditTableView.registerCell(nibName: ContactDetailTableViewCell.reusableIdentifier)
        self.addEditTableView.registerCell(nibName: ContactDeleteTableCell.reusableIdentifier)
    }
}

// MARK: - UITableViewDatasource ,UITableViewDelegate methods

extension AddEditContactVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel.usingFor == .add {
            return 4
        }
        else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4 {
            return 100.0
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 4 {
            // delete
            guard let cell = self.addEditTableView.dequeueReusableCell(withIdentifier: ContactDeleteTableCell.reusableIdentifier) as? ContactDeleteTableCell else {
                fatalError("ContactDeleteTableCell not found")
            }
            
            cell.deleteButtonAction = {
                AppGlobals.shared.showAlert(title: LocalizedStrings.Confirmation.localized, message: LocalizedStrings.AreYouSureToDelete.localized, successButtonTitle: LocalizedStrings.Yes.localized, cancelButtonTitle: LocalizedStrings.No.localized) { isSuccess in
                    if isSuccess {
                        self.viewModel.deleteContactAPI()
                    }
                }
            }
            
            return cell
        }
        else {
            guard let cell = self.addEditTableView.dequeueReusableCell(withIdentifier: ContactDetailTableViewCell.reusableIdentifier) as? ContactDetailTableViewCell else {
                fatalError("ContactDetailTableViewCell not found")
            }
            cell.delegate = self
            switch indexPath.row {
            case 0: // First Name
                cell.configureCell(title: LocalizedStrings.FirstName.localized, isEditingEnabled: true, inputText: self.viewModel.usingFor == .add ? "" : self.viewModel.contact?.firstName ?? "", placeHolder: LocalizedStrings.FirstName.localized)
                cell.delegate = self
                return cell
                
            case 1: // Last Name
                cell.configureCell(title: LocalizedStrings.LastName.localized, isEditingEnabled: true, inputText: self.viewModel.usingFor == .add ? "" : self.viewModel.contact?.lastName ?? "", placeHolder: LocalizedStrings.LastName.localized)
                
                return cell
            // Mobile
            case 2:
                cell.configureCell(title: LocalizedStrings.Mobile.localized, isEditingEnabled: true, inputText: self.viewModel.usingFor == .add ? "" : self.viewModel.contact?.phoneNumber ?? "", placeHolder: LocalizedStrings.Mobile.localized)
                
                return cell
                
            case 3: // email
                cell.configureCell(title: LocalizedStrings.Email.localized, isEditingEnabled: true, inputText: self.viewModel.usingFor == .add ? "" : self.viewModel.contact?.email ?? "", placeHolder: LocalizedStrings.Email.localized)
                return cell
            default:
                return UITableViewCell()
            }
        }
    }
}

// MARK: - ContactAddEditHeaderViewDelegate methods

extension AddEditContactVC: ContactAddEditHeaderViewDelegate {
    func addPhotoButtonTapped() {
        self.captureImage(delegate: self)
    }
}

extension AddEditContactVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        self.viewModel.selectedImage = selectedImage
        self.setHeaderData()
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - ContactDetailTableViewCellDelegate methods

extension AddEditContactVC: ContactDetailTableViewCellDelegate {
    func textFieldText(textField: UITextField) {
        if let indexPath = self.addEditTableView.indexPath(forItem: textField) {
            switch indexPath.row {
            case 0: // First Name
                self.viewModel.contact?.firstName = textField.text ?? ""
            case 1: // Last Name
                self.viewModel.contact?.lastName = textField.text ?? ""
            case 2: // Mobile
                self.viewModel.contact?.phoneNumber = textField.text ?? ""
            case 3: // Email
                self.viewModel.contact?.email = textField.text ?? ""
            default:
                break
            }
        }
    }
}

// MARK: - AddEditContactVMDelegate methods

extension AddEditContactVC: AddEditContactVMDelegate {
    func deleteContactSuccess() {
        AppFlowManager.default.popToRootViewController(animated: true)
    }
    
    func willAddContact() {
        //
    }
    
    func addContactSuccess() {
        //
        AppFlowManager.default.popToRootViewController(animated: true)
    }
    
    func addContactFail() {
        //
    }
    
    func willUpdateContact() {
        //
    }
    
    func updateContactSuccess() {
        AppFlowManager.default.popViewController(animated: true)
    }
    
    func updateContactFail() {
        //
    }
}
