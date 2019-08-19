//
//  ContactDeleteTableCell.swift
//  Contacts
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//


import UIKit

class ContactDeleteTableCell: GJTableViewCell {

    // MARK: - IBOutlet
    
    // MARK: -
    
    @IBOutlet var deleteButton: UIButton!
    
    // MARK: - Properties
    var deleteButtonAction: (()->Void)? = nil
    
    // MARK: -
    
    /// MARK: - Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.deleteButton.layer.cornerRadius = 5.0
        self.deleteButton.layer.masksToBounds = true
    }
    
    override func doInitialSetup() {
    }
    
    override func setupFonts() {
        self.deleteButton.titleLabel?.font = AppFonts.SemiBold.withSize(16.0)
    }
    
    override func setupColors() {
        self.deleteButton.setTitleColor(AppColors.white, for: .normal)
        self.deleteButton.backgroundColor = AppColors.themeRed
    }
    
    override func setupTexts() {
        self.deleteButton.setTitle(LocalizedStrings.DELETE.localized, for: .normal)
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        if let action = self.deleteButtonAction {
            action()
        }
    }
}
