//
//  FirebaseManager.swift
//  STS
//
//  Created by Анна Гранёва on 12.07.22.
//

import UIKit
import FirebaseAuth

struct FirebaseManager{
    static func verifyPhoneNumber(phoneNumber: String?, completion: @escaping (String?) -> Void){
        guard let phoneNumber = phoneNumber else { return }
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            completion(verificationID)
        }
    }
    
    static func singIn(verificationID: String?, verificationCode: String?, completion: @escaping (Error?) -> Void){
        guard let verificationID = verificationID,
              let verificationCode = verificationCode else { return }
        let credetional = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        Auth.auth().signIn(with: credetional) { _, error in
            completion(error)
        }
    }
}
