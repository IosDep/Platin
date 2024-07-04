//
//  Color.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 04/02/2023.
//

import UIKit
/**
 Base Enum to access all Colors
  - Example :-  view.tintColor = .Background1
 */

enum Color: String {                                     // Light hex#  :: Dark hex#

    case Background                                            //FFFFFF :: 000000
    case ButtonBackground                                      //C9E4E6 :: 00313E
    case ButtonUnActiveBackground                                      //C9E4E6 :: 00313E
    case ButtonTitleColor                                      //C9E4E6 :: 00313E
    case TextBackground                                        //FFF8D1 :: 48421C
    case TextPlaceholder                                       //FFF8D1 :: 48421C
    case ButtonUnactiveTitle
    case TextPrimary
    case Success
    case canceled


    var color: UIColor {
        UIColor(named: self.rawValue) ?? .white
    }
}

extension UIColor {
    static var Background:            UIColor { Color.Background.color }
    static var ButtonBackground:           UIColor { Color.ButtonBackground.color }
    static var ButtonUnActiveBackground: UIColor {Color.ButtonUnActiveBackground.color}
    static var ButtonTitleColor:           UIColor { Color.ButtonTitleColor.color }
    static var ButtonUnactiveTitle:           UIColor { Color.ButtonUnactiveTitle.color }

    static var TextBackground:           UIColor { Color.TextBackground.color }
    static var TextPlaceholder:           UIColor { Color.TextPlaceholder.color }
    static var TextPrimary:   UIColor { Color.TextPrimary.color }
    static var Success:   UIColor { Color.Success.color }
    static var canceled: UIColor {Color.canceled.color}
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
