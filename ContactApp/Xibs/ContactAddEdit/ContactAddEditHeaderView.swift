//
//  ContactAddEditHeaderView.swift
//  Contacts
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//


import Foundation
import UIKit

protocol ContactAddEditHeaderViewDelegate: class {
    func addPhotoButtonTapped()
}

class ContactAddEditHeaderView: UIView {

    // MARK: - IBOutlet
    
    // MARK: -
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var mainContentView: UIView!
    
    // MARK: - Variables
    private var gradientLayer: CAGradientLayer!
    private let gradientColors: [UIColor] = [AppColors.white, AppColors.themeGreen.withAlphaComponent(0.5)]

    weak var delegate: ContactAddEditHeaderViewDelegate?
    
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
    
    class func instanceFromNib() -> ContactAddEditHeaderView {
        return UINib(nibName: "ContactAddEditHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ContactAddEditHeaderView
    }
    
    private func addGradientLayer() {
        if gradientLayer == nil {
            
            gradientLayer = CAGradientLayer()
            self.mainContentView.layer.insertSublayer(gradientLayer, at: 0)
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
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2
        self.profileImageView.layer.borderColor = UIColor.white.cgColor
        self.profileImageView.layer.borderWidth = 3
        self.profileImageView.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.profilePhotoButtonTapped))
        self.profileImageView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: Any) {
        printDebug("profiel button tapped")
        self.delegate?.addPhotoButtonTapped()
    }
    
    @objc func profilePhotoButtonTapped() {
        printDebug("profiel button tapped")
        self.delegate?.addPhotoButtonTapped()
    }
}
