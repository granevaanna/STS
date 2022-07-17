//
//  ButtonsTypeProfileCell.swift
//  STS
//
//  Created by Анна Гранёва on 16.07.22.
//

import UIKit

enum ProfileType{
    case basic
    case anonym
}

protocol ButtonsTypeProfileCellDelegate: AnyObject{
    func updateTableView(profileType: ProfileType)
}

class ButtonsTypeProfileCell: UITableViewCell {
    static let identifier = "kButtonsTypeProfileCell"
    
    @IBOutlet private weak var basicProfileButton: UIButton!
    @IBOutlet private weak var anonymProfileButton: UIButton!
    
    private(set) var currentType: ProfileType = .basic
    
    weak var delegate: ButtonsTypeProfileCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        basicProfileButton.isSelected = true
    }
    
    private func setBasicType(){
        currentType = .basic
        basicProfileButton.isSelected = true
        anonymProfileButton.isSelected = false
    }
    
    private func setAnonymType(){
        currentType = .anonym
        basicProfileButton.isSelected = false
        anonymProfileButton.isSelected = true
    }
    
    @IBAction func basicProfileButtonAction(_ sender: Any) {
        setBasicType()
        delegate?.updateTableView(profileType: currentType)
    }
    @IBAction func anonymProfileButtonAction(_ sender: Any) {
        setAnonymType()
        delegate?.updateTableView(profileType: currentType)
    }
}
