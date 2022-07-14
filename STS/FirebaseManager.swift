//
//  FirebaseManager.swift
//  STS
//
//  Created by Анна Гранёва on 12.07.22.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

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
    
    static func singInWithPhoneNumber(verificationID: String?, verificationCode: String?, completion: @escaping (Error?) -> Void){
        guard let verificationID = verificationID,
              let verificationCode = verificationCode else { return }
        let credetional = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        Auth.auth().signIn(with: credetional) { _, error in
            completion(error)
        }
    }
    
    static func singInWithGoogle(viewController: UIViewController, completion: @escaping (Error?) -> Void){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: viewController) { user, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { _, error in
                completion(error)
            }
        }
    }
}
