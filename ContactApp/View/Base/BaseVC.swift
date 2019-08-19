//
//  BaseVC.swift
//  ContactApp
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

/**********************************
 
 A Base UIViewController will provide some usefull methods
 each view controller in app will be inherited from this class
 
 ***********************************/

class BaseVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        
        self.initialSetup()
        self.setupFonts()
        self.setupTexts()
        self.setupColors()
        self.setupNavBar()
    }
    
    // MARK: Override functions
    
    func bindViewModel() {
    }
}

extension BaseVC {
    /// Initial Setup
    @objc func initialSetup() {
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
    
    /// Setup up Nav Bar
    
    @objc func setupNavBar() {
    }
}
