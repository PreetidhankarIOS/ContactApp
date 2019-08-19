//
//  UITableViewCellExtension.swift
//  ContactApp
//
//  Created by Pawan Kumar on 18/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    class var reusableIdentifier: String {
        return "\(self)"
    }
    
    var indexPath: IndexPath? {
        if let tblVw = self.superview as? UITableView {
            return tblVw.indexPath(for: self)
        }
        return nil
    }
}
