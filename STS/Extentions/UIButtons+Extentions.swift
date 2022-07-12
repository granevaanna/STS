//
//  UIButtons+Extentions.swift
//  STS
//
//  Created by Анна Гранёва on 12.07.22.
//

import UIKit

extension UIButton{
    func mainButton(){
        isEnabled = true
        backgroundColor = UIColor.mainColor
        titleLabel?.textColor = .white
        layer.cornerRadius = 10
    }
    
    func blockButton(){
        isEnabled = false
        backgroundColor = .lightGray
        layer.cornerRadius = 10
    }
}
