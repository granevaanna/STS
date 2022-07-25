//
//  BasicProfileModel.swift
//  STS
//
//  Created by Анна Гранёва on 18.07.22.
//

import UIKit
import FirebaseAuth

struct BasicProfileModel{
    var name: String
    var surname: String
    var phoneNumber: String
    var country: String
    var city: String
    var mail: String
    var dateOfBirth: String
    var image: UIImage?
    
    var fullName: String{
        return "\(name) \(surname)"
    }
    
    init(){
        name = ""
        surname = ""
        if let currentUserPhoneNumber = FirebaseManager.getPhoneNumber(){
            phoneNumber = currentUserPhoneNumber
        } else{
            phoneNumber = ""
        }
        
        country = ""
        city = ""
        mail = ""
        dateOfBirth = ""
        image = UIImage(systemName: "person.circle")
    }
}
