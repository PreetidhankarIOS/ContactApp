//
//  ContactListTableViewCell.swift
//  Contacts
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import UIKit

class ContactListTableViewCell: GJTableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var dividerView: GJDividerView!
    
    // MARK: - Properties
    
    var contact: Contact? {
        didSet {
            self.configureCell()
        }
    }
    
    override func doInitialSetup() {
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2
        self.profileImageView.layer.masksToBounds = true
        self.profileImageView.layer.borderWidth = 1.0
        self.profileImageView.layer.borderColor = AppColors.divider.withAlphaComponent(0.7).cgColor
        self.profileImageView.backgroundColor = AppColors.white
    }
    
    override func setupFonts() {
        self.userNameLabel.font = AppFonts.Bold.withSize(14.0)
    }
    
    override func setupColors() {
        self.userNameLabel.textColor = AppColors.themeText
    }
    
    private func configureCell() {
        self.userNameLabel.text = self.contact?.fullName
        self.favouriteButton.isSelected = self.contact?.isFavourite ?? false
        
        self.profileImageView.setImage(from: self.contact?.profileUrlPath ?? "", placeHolder: AppPlaceholder.profile, contentMode: .scaleAspectFill)
    }
}
