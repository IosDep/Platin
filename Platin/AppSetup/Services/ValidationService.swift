//
//  ValidationService.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 07/02/2023.
//

import Foundation

protocol ValidationServiceProtocol: AnyObject {
    func validateEmailEntry(email: String) -> (Bool, String?)
    func validatePhoneNumberEntry(phone: String) -> (Bool, String?)
    func validatePasswordEntry(password: String) -> (Bool, String?)
    func validateName(name: String) -> String?
    func isEntryNumber(entry: String) -> Bool
}

class ValidationService: ValidationServiceProtocol {

    func validateEmailEntry(email: String) -> (Bool, String?) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           if emailTest.evaluate(with: email) {
               return (true, nil)
           } else {
               return (false, "Invalid email format")
           }
    }

    func validatePhoneNumberEntry(phone: String) -> (Bool, String?) {
        let phoneNumberRegEx = "^[+]?[0-9]{0,}$"
          let phoneNumberTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegEx)
          if phoneNumberTest.evaluate(with: phone) {
              return (true, nil)
          } else {
              return (false, "Invalid phone number format")
          }
    }

    func validatePasswordEntry(password: String) -> (Bool, String?) {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        if  passwordTest.evaluate(with: password) {
            return (true, nil)
        } else {
            return (false, "Invalid phone number format")
        }
    }

    func validateName(name: String) -> String? {
        return nil
    }

    func isEntryNumber(entry: String) -> Bool {
        return Double(entry) != nil
    }
}
