//
//  AppConfigurationConstants.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 07/02/2023.
//

import Foundation
// Configuration
enum Configuration {

    enum Errors {
        static let passwordValidationError = """
 1_ Password must be at least 8 characters long
 2_ Password must contain at least one special character (!, @, #, $, %, etc.)
 3_ Password must contain at least one lowercase letter
 4_ Password must contain at least one number
"""
        static let emailValidationError = """
 1_ Email address should be in format of 'username@domain.com'
 2_ Email address must contain '@' symbol
 3_ Please enter a valid domain name after '@' symbol
"""

        static let phoneValidationError = """
 1_ Phone number can only contain numbers
 2_ Phone number between 8 to 14 numbers
 3_ make sure to choose your country code 
"""
        static let OTPErrorEmptyFiled = "OTP field cannot be empty"
        static let missingFields = "Please make sure to fill all required fields"
        static let missingDocuments = "Please make sure to add your back and front Id"
        static let missingNationality = "Please make sure to choose your Nationality"
        static let privacyAndPolicyAcceptError = "Please accept Cardizer Privacy And Policy"
    }
}
