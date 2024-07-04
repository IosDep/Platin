//
//  PrimaryTextField.swift
//  KEENZALARAB
//
//  Created by Osama Abu hdba on 08/01/2024.
//

import Foundation
import UIKit

class PrimaryTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        self.delegate = self
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.cornerRadius = 5
        clipsToBounds = true 
      
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [
            .foregroundColor: #colorLiteral(red: 0.5647058824, green: 0.5647058824, blue: 0.5647058824, alpha: 1)
        ])
        semanticContentAttribute = .forceLeftToRight
        
        layer.borderColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
        layer.borderWidth = 1.0

        self.textAlignment = Helper.appLanguage == "en" ? .left : .right
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension PrimaryTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.layer.borderWidth = 1.0
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        textField.layer.borderWidth = 0.5
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return true
    }

}
