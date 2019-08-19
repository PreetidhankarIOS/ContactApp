//
//  UITableViewExtension.swift
//  ContactApp
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func registerCell(nibName: String, bundle: Bundle? = Bundle.main, forCellWithReuseIdentifier: String? = nil) {
        let cellWithReuseIdentifier = forCellWithReuseIdentifier ?? nibName
        self.register(UINib(nibName: nibName, bundle: bundle), forCellReuseIdentifier: cellWithReuseIdentifier)
    }
    
    func indexPath(forItem: AnyObject) -> IndexPath? {
        let itemPosition: CGPoint = forItem.convert(CGPoint.zero, to: self)
        return self.indexPathForRow(at: itemPosition)
    }
}
