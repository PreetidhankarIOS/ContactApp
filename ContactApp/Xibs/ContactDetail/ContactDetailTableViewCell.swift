//
//  ContactDetailTableViewCell.swift
//  Contacts
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import UIKit

protocol ContactDetailTableViewCellDelegate: class {
    func textFieldText(textField: UITextField)
}

class ContactDetailTableViewCell: GJTableViewCell {

    // MARK: - IBOutlet
    
    // MARK: -
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    // MARK: - Properties
    
    // MARK: -
    
    weak var delegate: ContactDetailTableViewCellDelegate?
    
    /// MARK: - Override methods
    
    override func doInitialSetup() {
        self.inputTextField.addTarget(self, action: #selector(self.textFieldValueChanged(_:)), for: .editingChanged)
    }
    
    override func setupFonts() {
        self.titleLabel.font = AppFonts.Regular.withSize(15.0)
        self.inputTextField.font = AppFonts.Regular.withSize(16.0)
    }
    
    override func setupColors() {
        self.titleLabel.textColor = AppColors.detailTitle
        self.inputTextField.textColor = AppColors.themeText
    }
    
    func configureCell(title: String, isEditingEnabled: Bool = true, inputText: String, placeHolder: String = "") {
        self.titleLabel.text = title
        self.inputTextField.isUserInteractionEnabled = isEditingEnabled
        self.inputTextField.text = inputText
        self.inputTextField.placeholder = placeHolder
    }
}

// MARK: - UITextFieldDelegate methods

extension ContactDetailTableViewCell: UITextFieldDelegate {
    @objc func textFieldValueChanged(_ textField: UITextField) {
        self.delegate?.textFieldText(textField: textField)
    }
}
