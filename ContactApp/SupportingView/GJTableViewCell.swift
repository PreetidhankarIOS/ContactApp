//
//  GJTableViewCell.swift
//  ContactApp
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//
/*
GJ Stands for "Go-Jek"
*/

import UIKit

class GJTableViewCell: UITableViewCell {
    
    // MARK: - View life cycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.intitalSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupFonts()
        self.setupTexts()
        self.setupColors()
        self.doInitialSetup()
    }
    
    private func intitalSetup() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
    }
    
    /// Setup Fonts
    
    @objc func setupFonts() {
    }
    
    /// Setup Colors
    
    @objc func setupColors() {
    }
    
    /// Setup Texts
    
    @objc func setupTexts() {
    }
    
    /// Do Inital setup
    
    @objc func doInitialSetup() {
    }
}
