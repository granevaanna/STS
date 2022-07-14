//
//  CallsCollectionCell.swift
//  STS
//
//  Created by Анна Гранёва on 14.07.22.
//

import UIKit

class CallsCollectionCell: UICollectionViewCell {
    static let identifier = "kCallsCollectionCell"
    @IBOutlet private weak var textLabel: UILabel!
    
    func setup(text: String){
        textLabel.text = text
    }
}
