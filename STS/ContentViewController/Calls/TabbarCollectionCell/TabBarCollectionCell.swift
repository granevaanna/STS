//
//  TabBarCollectionCell.swift
//  STS
//
//  Created by Анна Гранёва on 14.07.22.
//

import UIKit

class TabBarCollectionCell: UICollectionViewCell {
    static let identifier = "kTabBarCollectionCell"
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet weak var selectView: UIView!
    
    func setup(tabBarCallsModel: TabBarCallsModel){
        textLabel.text = tabBarCallsModel.tabBarName
        selectView.isHidden = tabBarCallsModel.isSelect ? false:true
        
//        if tabBarCallsModel.isSelect{
//            selectView.isHidden = false
//        } else{
//            selectView.isHidden = true
//        }
    }
}
