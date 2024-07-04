//
//  UIColor+Ex.swift
//  Cardizerr Admin
//
//  Created by yazed raed on 24/08/2023.
//

import UIKit

extension UIColor {
    func toHex() -> String? {
        guard let components = self.cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let red = Float(components[0])
        let green = Float(components[1])
        let blue = Float(components[2])
        
        let hexString = String(format: "#%02lX%02lX%02lX", lroundf(red * 255), lroundf(green * 255), lroundf(blue * 255))
        
        return hexString
    }
}
