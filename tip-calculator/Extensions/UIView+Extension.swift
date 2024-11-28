//
//  UIView+Extension.swift
//  tip-calculator
//
//  Created by UsamaShafiq on 22/11/2024.
//

import Foundation
import UIKit

extension UIView {
    
    func applyShadow(offset: CGSize,
                     color: UIColor,
                     radius: CGFloat,
                     opacity: Float) {
        
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.cornerRadius = radius
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        self.layer.masksToBounds = false

    }
}
