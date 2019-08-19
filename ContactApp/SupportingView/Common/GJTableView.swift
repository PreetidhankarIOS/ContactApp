//
//  GJTableView.swift
//  ContactApp
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

/*
 GJ Stands for "Go-Jek"
 */

import UIKit

class GJTableView: UITableView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.intitalSetup()
    }
    
    private func intitalSetup() {
        self.keyboardDismissMode = .onDrag
        self.separatorStyle = .none
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = AppColors.defaultTableViewBackgroundColor
    }
    
}
