//
//  UIColors+Extentions.swift
//  STS
//
//  Created by Анна Гранёва on 12.07.22.
//

import UIKit

extension UIColor{
    @nonobjc class var mainColor: UIColor {
        return UIColor(named: "mainColor") ?? UIColor(cgColor: CGColor(red: 0.18, green: 0.31, blue: 0.59, alpha: 1))
    }
}

