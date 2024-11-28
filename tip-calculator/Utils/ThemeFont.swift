//
//  ThemeFont.swift
//  tip-calculator
//
//  Created by UsamaShafiq on 22/11/2024.
//

import Foundation
import UIKit

struct ThemeFont {
    
    static func regular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func bold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    
    static func demiBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-DemiBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
    }
}
