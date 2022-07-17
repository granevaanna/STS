//
//  ProfileModel.swift
//  STS
//
//  Created by Анна Гранёва on 17.07.22.
//

import UIKit
import FirebaseAuth

struct ProfileModel{
    var name: String?
    var surname: String?
    var phoneNumber: String
    var country: String?
    var city: String?
    var mail: String?
    var dateOfBirth: String?
    var image: UIImage?
    
    var nickname: String?
    var placeOfresidence: String?
    var gender: Int?
    var ageCategory: String?
    
    var fullName: String{
        var full = ""
        if let name = name, let surname = surname {
            full = "\(name) \(surname)"
        } else if let name = name {
            full = name
        } else if let surname = surname {
            full = surname
        }
        return full
    }
    
    init(){
        if let currentUserPhoneNumber = Auth.auth().currentUser?.phoneNumber{
            phoneNumber = currentUserPhoneNumber
        } else{
            phoneNumber = ""
        }
        
        image = UIImage(systemName: "person.circle")
    }
}
