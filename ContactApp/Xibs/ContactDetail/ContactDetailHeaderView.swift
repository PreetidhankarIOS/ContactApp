//
//  ContactDetailHeaderView.swift
//  Contacts
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import UIKit

class ContactDetailHeaderView: UIView {


    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var callLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var favLabel: UILabel!
    @IBOutlet weak var mainContainerView: UIView!
    
    private var gradientLayer: CAGradientLayer!
    private let gradientColors: [UIColor] = [AppColors.white, AppColors.themeGreen.withAlphaComponent(0.5)]
    
    var contactDetail: Contact? {
        didSet {
            self.configureData()
        }
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addGradientLayer()
        self.doInitalSetup()
        self.profileImageView.backgroundColor = AppColors.white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if gradientLayer != nil {
            self.updateGradientLayer(gLayer: self.gradientLayer)
        }
    }
    
    // MARK: - Helper methods
    
    class func instanceFromNib() -> ContactDetailHeaderView {
        return UINib(nibName: "ContactDetailHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ContactDetailHeaderView
    }
    
    
    private func addGradientLayer() {
        if gradientLayer == nil {
            
            gradientLayer = CAGradientLayer()
            self.mainContainerView.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        self.updateGradientLayer(gLayer: self.gradientLayer)
    }
    
    private func updateGradientLayer(gLayer: CAGradientLayer) {
        gLayer.frame = self.bounds
        gLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        gLayer.masksToBounds = true
        
        gLayer.colors = gradientColors.map { (clr) -> CGColor in
            clr.cgColor
        }
    }
    
    private func doInitalSetup() {
        self.profileImageView.layer.cornerRadius  = self.profileImageView.frame.size.width / 2
        self.profileImageView.layer.borderColor = UIColor.white.cgColor
        self.profileImageView.layer.borderWidth = 3
        self.profileImageView.layer.masksToBounds = true

        self.setUpFont()
        self.setUpColor()
    }
    
    private func setUpFont() {
        self.userNameLabel.font = AppFonts.Bold.withSize(18.0)
        
        self.messageLabel.font = AppFonts.Regular.withSize(11.0)
        self.callLabel.font = AppFonts.Regular.withSize(11.0)
        self.emailLabel.font = AppFonts.Regular.withSize(11.0)
        self.favLabel.font = AppFonts.Regular.withSize(11.0)
    }
    
    private func setUpColor() {
        self.userNameLabel.textColor = AppColors.userNameColor
        
        self.messageLabel.text = LocalizedStrings.Message.localized
        self.callLabel.text = LocalizedStrings.Call.localized
        self.emailLabel.text = LocalizedStrings.Email.localized
        self.favLabel.text = LocalizedStrings.Favourite.localized
    
    }
    
    private func configureData() {
        self.profileImageView.setImage(from: self.contactDetail?.profileUrlPath ?? "", placeHolder: AppPlaceholder.profile, contentMode: .scaleAspectFill)
        self.userNameLabel.text = self.contactDetail?.fullName ?? LocalizedStrings.Dash.localized
        self.favButton.isSelected = self.contactDetail?.isFavourite ?? false
    }
}

