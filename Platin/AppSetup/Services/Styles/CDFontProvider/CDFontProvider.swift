//
//  CDFontProvider.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 11/02/2023.
//

import UIKit
import Resolver

enum CDFontStyle: String {
    case extraLight
    case light
    case regular
    case medium
    case semiBold
    case bold
    case extraBold
    case black
}

struct CDFont: Equatable {
    let style: CDFontStyle
    let size: CGFloat
    var currentLanguage: Int

    init(currentLanguage: Int? = 0, style: CDFontStyle, size: CGFloat) {
        @Injected var preferencesManager: PreferencesManager
//        self.currentLanguage  = preferencesManager.currentLanguageIndex == "en" ? 1 : 0
        self.currentLanguage = currentLanguage ?? 0
        // 1: for English
        // 0: for Arabic
        self.style = style
        self.size = size
    }

    var name: String {
        let prefix = "Mulish-"
        switch style {
        case .extraLight:
            return currentLanguage == 1 ? "\(prefix)ExtraLight" : "Gelion-Light"
        case .light:
            return currentLanguage == 1 ? "\(prefix)Light" : "Gelion-Light"
        case .regular:
            return currentLanguage == 1 ? "\(prefix)Regular" : "Gelion-Regular"
        case .medium:
            return currentLanguage == 1 ? "\(prefix)Medium" : "Gelion-Medium"
        case .semiBold:
            return currentLanguage == 1 ? "\(prefix)SemiBold" : "Gelion-SemiBold"
        case .bold:
            return currentLanguage == 1 ? "\(prefix)Bold" : "Gelion-Bold"
        case .extraBold:
            return currentLanguage == 1 ? "\(prefix)ExtraBold" : "Gelion-Black"
        case .black:
            return currentLanguage == 1 ? "\(prefix)Black" : "Gelion-Black"
        }
    }

//    var font: UIFont {
//        UIFont(name: name, size: size)!
//    }
}

extension UIFont {
//    class func font(for style: CDFontStyle, size: CGFloat) -> UIFont {
//        CDFont(style: style, size: size).font
//    }
}
