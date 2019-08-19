//
//  EmptyScreenView.swift
//  Contacts
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import UIKit

protocol EmptyScreenViewDelegate: class {
    func firstButtonAction(sender: UIButton)
    func bottomButtonAction(sender: UIButton)
}

extension EmptyScreenViewDelegate {
    func bottomButtonAction(sender: UIButton) {}
}

class EmptyScreenView: UIView {
    
    enum EmptyScreenViewType {
        case none
        case noDataFound
    }
    
    //MARK:- properties -
    weak var delegate: EmptyScreenViewDelegate?
    var vType: EmptyScreenViewType = .none {
        didSet {
            self.initialSetup()
        }
    }
    
    //MARK:- IBOutlets -
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var firstButtonContainerView: UIView! {
        didSet {
            firstButtonContainerView.backgroundColor = AppColors.clear
        }
    }
    @IBOutlet weak var containerViewCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainImageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTextLabel: UILabel!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var firstbuttonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomButtonTopConstraint: NSLayoutConstraint!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
        self.initialSetup()
    }
    
    init() {
        super.init(frame: .zero)
        
        self.commonInit()
        self.initialSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
        self.initialSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupView()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("\(EmptyScreenView.self)", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        bottomButton.isHidden = true
    }
    
    //MARK:- Private Function -
    @IBAction func firstButtonAction(_ sender: UIButton) {
        self.delegate?.firstButtonAction(sender: sender)
    }
    @IBAction func bottomButtonAction(_ sender: UIButton) {
        self.delegate?.bottomButtonAction(sender: sender)
    }
}

extension EmptyScreenView {
    
    /// - Initial Setup -
    private func initialSetup() {
        self.setupView()
    }
    
    private func setupView() {
        switch self.vType {
        case .none:
            self.setupForNone()
        case .noDataFound:
            self.setupForNoDataFound()
        }
    }
    
    private func hideFirstButton(isHidden: Bool) {
        self.firstButtonContainerView.isHidden = isHidden
        self.firstbuttonHeightConstraint.constant = isHidden ? 0.0 : 45.0
        self.firstButtonTopConstraint.constant = isHidden ? 0.0 : 20.0
    }
    
    private func hideBottomButton(isHidden: Bool) {
        self.bottomButton.isHidden = isHidden
        self.bottomButtonHeightConstraint.constant = isHidden ? 0.0 : 45.0
        self.bottomButtonTopConstraint.constant = isHidden ? 0.0 : 10.0
    }
    
    //MARK: - Tenant My Apartments -
    private func setupForNone() {
        self.hideFirstButton(isHidden: true)
        self.mainImageView.image = nil
        self.messageLabel.font = AppFonts.SemiBold.withSize(20.0)
        self.messageLabel.textColor = AppColors.themeGreen
        self.messageLabel.text = LocalizedStrings.noData.localized
    }
    
    private func setupForNoDataFound() {
        
        self.mainImageView.tintColor = AppColors.themeGreen
        self.mainImageView.image = #imageLiteral(resourceName: "ic_no_data").withRenderingMode(.alwaysTemplate)
        
        self.messageLabel.font = AppFonts.SemiBold.withSize(22.0)
        self.messageLabel.textColor = AppColors.themeGreen
        self.messageLabel.text = LocalizedStrings.noData.localized
        
        self.searchTextLabel.isHidden = true
        
        self.hideBottomButton(isHidden: true)
        self.hideFirstButton(isHidden: false)
        self.firstButton.titleLabel?.font = AppFonts.SemiBold.withSize(18.0)
        self.firstButton.setTitle("\(LocalizedStrings.tryAgain.localized)", for: .normal)
        self.firstButton.setTitle("\(LocalizedStrings.tryAgain.localized)", for: .selected)
        self.firstButton.setTitleColor(AppColors.white, for: .normal)
        self.firstButton.setTitleColor(AppColors.white, for: .selected)
        
        self.firstButton.backgroundColor = AppColors.themeGreen
        self.firstButton.layer.cornerRadius = 5.0
        self.firstButton.layer.masksToBounds = true
    }
}
