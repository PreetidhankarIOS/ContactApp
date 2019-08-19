//
//  GJDividerView.swift
//  Contacts
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

/*
 GJ Stands for "Go-Jek"
 */

import UIKit

open class GJDividerView: UIView {

    // MARK: - View Life Cycle
    
    // MARK: -
    
    init() {
        super.init(frame: CGRect.zero)
        self.initialSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialSetup()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.updatedFrame()
    }
    
    // MARK: - Properties
    
    // MARK: - Private
    
    // MARK: - Public
    
    var defaultHeight: CGFloat = 1.0 {
        didSet {
            self.updatedFrame()
        }
    }
    
    var defaultBackgroundColor: UIColor = AppColors.divider { 
        didSet {
            self.updatedBackgroundColor()
        }
    }
    
    // MARK: - Methods
    
    // MARK: - Private
    
    private func initialSetup() {
        self.updatedFrame()
        self.updatedBackgroundColor()
    }
    
    private func updatedBackgroundColor() {
        self.backgroundColor = self.defaultBackgroundColor
    }
    
    private func updatedFrame() {
        self.frame = CGRect(x: self.x, y: self.y, width: self.width, height: self.defaultHeight)
    }
}
