//
//  PKActivityIndicatorAnimation.swift
//
//  Created by Pawan Kumar on 07/09/18.
//  Copyright © 2018 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

public final class PKActivityIndicatorAnimation: PKIndicatorAnimationDelegate {
    public func setUpAnimation(in view: UIView, size: CGSize, color: UIColor) {
        let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activity.color = color
        activity.startAnimating()
        activity.center = view.center
        view.addSubview(activity)
    }
}
