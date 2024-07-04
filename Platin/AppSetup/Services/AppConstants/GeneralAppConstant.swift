//
//  GeneralAppConstants.swift
//  CARDIZERR
//
//  Created by Osama Abu hdba on 26/07/2022.
//

import UIKit
import LanguageManager_iOS
import CommonCrypto

protocol GeneralAppConstantsProtocol {
//    static var phoneNumberLength: Int {get set}
}

struct GeneralAppConstants: GeneralAppConstantsProtocol {
    /*
     Detect when the app is running on debug, testflight, or regular appStore
     */

    enum AppEnvironment {
        case debug
        case testFlight
        case appStore
    }
    
    static func amIBeingDebugged() -> Bool {
        var info = kinfo_proc()
        var mib : [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        var size = MemoryLayout<kinfo_proc>.stride
        let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
        assert(junk == 0, "sysctl failed")
        return (info.kp_proc.p_flag & P_TRACED) != 0
    }

    static func getHashKey() -> String {
         let aesKey = "AXe8YwuIn1zxt3FPWTZFlAa14EHdPAdN9FaZ9RQWihc="
         let aesIv = "bsxnWolsAyO7kCfWuyrnqg=="
         let key = "DomC_@r3"

         // Get the current timestamp
         let timestamp = Int(Date().timeIntervalSince1970) * 1000

         // Concatenate the key and timestamp
         let dataToEncrypt = key + String(timestamp)

         // Convert the data to be encrypted to Data
         let data = dataToEncrypt.data(using: .utf8)

         // Convert the AES key and IV to Data
         let aesKeyData = Data(base64Encoded: aesKey)
         let aesIVData = Data(base64Encoded: aesIv)

         // Create a buffer to hold the encrypted data
         var buffer = [UInt8](repeating: 0, count: data!.count + kCCBlockSizeAES128)

         // Perform the encryption
         var bytesEncrypted = 0
         let status = CCCrypt(CCOperation(kCCEncrypt),
                             CCAlgorithm(kCCAlgorithmAES),
                             CCOptions(kCCOptionPKCS7Padding),
                             (aesKeyData! as NSData).bytes,
                             kCCKeySizeAES256,
                             (aesIVData! as NSData).bytes,
                             (data! as NSData).bytes,
                             data!.count,
                             &buffer,
                             buffer.count,
                             &bytesEncrypted)

         // Check for encryption errors
         if status != kCCSuccess {
             print("Encryption failed with status: \(status)")
             return ""
         }

         // Trim the buffer to the number of bytes actually encrypted
         let encryptedData = Data(bytes: buffer, count: bytesEncrypted)

         // Convert the encrypted data to a base64 encoded string
         let base64EncryptedString = encryptedData.base64EncodedString()
         print(base64EncryptedString)
         return base64EncryptedString

     }
    
    
    static var _isRTL: Bool {
        LanguageManager.shared.isRightToLeft
    }

//    static var systemType: SystemType {
//        @Injected var preferencesManager: PreferencesManager
//        return SystemType(rawValue: preferencesManager.systemType!) ?? .cards
//    }
    
    static var OTPMaxLength = 6
    static var OTPResendCodeTimeout = 300
    static var phoneNumberLength: Int = 10
    {
        didSet {
            print ("Value changed to \(phoneNumberLength)")
        }
    }

    static var phoneNumberMinimumLength: Int = 7
    {
        didSet {
            print ("Value changed to \(phoneNumberLength)")
        }
    }
    
    static var languageIdentifier: String {
        LanguageManager.shared.currentLanguage.rawValue
    }
    
    static var deviceID: String {
        UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    }
    
    static var appEnvironment: AppEnvironment {
        let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
        
#if DEBUG
        return .debug
#else
        if isTestFlight {
            return .testFlight
        } else {
            return .appStore
        }
#endif
    }
}

enum ResidencyStatus: Int, Codable {
    case resident = 1
    case notResident
    case undefined
}

extension NSObject {
    var _isRTL: Bool {
        LanguageManager.shared.isRightToLeft
    }
}

extension String {
    var localized: String {
        localiz()
    }
}
