//
//  PWManager.swift
//  PWManager
//
//  Created by chaichai on 2023/5/8.
//

import Foundation
import UIKit

extension PWManager {
    enum FontFamily {
        case poppins
        case din
        
        var familyName: String {
            switch self {
            case .poppins: return "Poppins"
            case .din: return "DIN"
            }
        }
        
        func font(_ type: FontType) -> String {
            return familyName + "-" + type.name
        }
    }
}

extension PWManager.PaywallView.Resources {
    
    fileprivate func font(family: PWManager.FontFamily, type: PWManager.FontType, fontSize: CGFloat) -> UIFont {
        return font(family.font(type), fontSize: fontSize)
    }
    
    /// poppins字体
    func font(poppins type: PWManager.FontType, fontSize: CGFloat) -> UIFont {
        return font(family: .poppins, type: type, fontSize: fontSize)
    }
    
    ///din字体
    func font(din type: PWManager.FontType, fontSize: CGFloat) -> UIFont {
        return font(family: .poppins, type: type, fontSize: fontSize)
    }
}
    
extension PWManager {
    public enum FontType: String {
        case extraLight
        case light
        case medium
        case extraBold
        case regular
        case bold
        case black
        case thin
        case semiBold
        case semiBoldItalic
        case extraBoldItalic
        case lightItalic
        case thinItalic
        case boldItalic
        case italic
        case blackItalic
        case extraLightItalic
        
        var name: String {
            return rawValue
        }
    }
}
