//
//  UIResponder+Extension.swift
//  tip-calculator
//
//  Created by UsamaShafiq on 28/11/2024.
//

import Foundation
import UIKit

extension UIResponder {
    
    var parentController: UIViewController? {
        return next as? UIViewController ?? next?.parentController
    }
}
