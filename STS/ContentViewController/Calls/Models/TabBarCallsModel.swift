//
//  TabBarCallsModel.swift
//  STS
//
//  Created by Анна Гранёва on 14.07.22.
//

import UIKit

struct TabBarCallsModel{
    let tabBarName: String
    var isSelect: Bool
    
    init(tabBarName: String){
        self.tabBarName = tabBarName
        self.isSelect = false
    }
}
