//
//  AnonymProfileCell.swift
//  STS
//
//  Created by Анна Гранёва on 16.07.22.
//

import UIKit

protocol AnonymProfileCellDelegate: AnyObject{
    func getAnonymAditUser(anonymUser: AnonymProfileModel)
}

class AnonymProfileCell: UITableViewCell {
    static let identifier = "kAnonymProfileCell"
    
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private var labels: [UILabel]!
    @IBOutlet private var textFields: [UITextField]!
    @IBOutlet private weak var saveButton: UIButton!
    
    weak var delegate: AnonymProfileCellDelegate?
    
    private enum TextFieldtype: Int{
        case nickname = 0
        case placeOfresidence = 1
        case gender = 2
        case ageCategory = 3
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 10
        saveButton.mainButton()
    }
    
    func setup(currentAnonymUser: AnonymProfileModel){
        textFields.first(where: { $0.tag == TextFieldtype.nickname.rawValue})?.text = currentAnonymUser.nickname
        textFields.first(where: { $0.tag == TextFieldtype.placeOfresidence.rawValue})?.text = currentAnonymUser.placeOfresidence
        textFields.first(where: { $0.tag == TextFieldtype.gender.rawValue})?.text = currentAnonymUser.gender
        textFields.first(where: { $0.tag == TextFieldtype.ageCategory.rawValue})?.text = currentAnonymUser.ageCategory
        
        for i in 0...textFields.count - 1 {
            if textFields[i].text?.isEmpty == nil{
                labels.first(where: { $0.tag == textFields[i].tag})?.isHidden = false
            } else {
                labels.first(where: { $0.tag == textFields[i].tag})?.isHidden = true
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    @IBAction private func textFieldsBeginAction(_ sender: UITextField) {
        labels.first(where: { $0.tag == sender.tag})?.isHidden = false
    }
    
    @IBAction private func textFieldsEndAction(_ sender: UITextField) {
        if let text = textFields.first(where: {$0.tag == sender.tag})?.text, text.isEmpty{
            labels.first(where: { $0.tag == sender.tag})?.isHidden = true
        } else{
            labels.first(where: { $0.tag == sender.tag})?.isHidden = false
        }
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        var currentUser: AnonymProfileModel = AnonymProfileModel()
        
        guard let nickname = textFields.first(where: { $0.tag == TextFieldtype.nickname.rawValue})?.text,
                let placeOfresidence = textFields.first(where: { $0.tag == TextFieldtype.placeOfresidence.rawValue})?.text,
                let gender = textFields.first(where: { $0.tag == TextFieldtype.gender.rawValue})?.text,
                let ageCategory = textFields.first(where: { $0.tag == TextFieldtype.ageCategory.rawValue})?.text else {return}
        
        currentUser.nickname = nickname
        currentUser.placeOfresidence = placeOfresidence
        currentUser.gender = gender
        currentUser.ageCategory = ageCategory
        
        delegate?.getAnonymAditUser(anonymUser: currentUser)
    }
}
