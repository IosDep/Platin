//
//  UITextField+EX.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 08/02/2023.
//

import UIKit

private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
               return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }

    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = "\(t?.prefix(maxLength) ?? "")"
    }
}
