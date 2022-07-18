//
//  BasicProfileCell.swift
//  STS
//
//  Created by Анна Гранёва on 16.07.22.
//

import UIKit

protocol BasicProfileCellDelegate: AnyObject{
    func getBasicAditUser(basicUser: BasicProfileModel)
}

class BasicProfileCell: UITableViewCell {
    static let identifier = "kBasicProfileCell"
    
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private var labels: [UILabel]!
    @IBOutlet private var textFields: [UITextField]!
    @IBOutlet private weak var saveButton: UIButton!
    
    weak var delegate: BasicProfileCellDelegate?
    
    private enum TextFieldtype: Int{
        case name = 0
        case surname = 1
        case country = 2
        case city = 3
        case mail = 4
        case dateOfBirth = 5
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 10
        saveButton.mainButton()
    }
    
    func setup(currentBasicUser: BasicProfileModel){
        textFields.first(where: { $0.tag == TextFieldtype.name.rawValue})?.text = currentBasicUser.name
        textFields.first(where: { $0.tag == TextFieldtype.surname.rawValue})?.text = currentBasicUser.surname
        textFields.first(where: { $0.tag == TextFieldtype.country.rawValue})?.text = currentBasicUser.country
        textFields.first(where: { $0.tag == TextFieldtype.city.rawValue})?.text = currentBasicUser.city
        textFields.first(where: { $0.tag == TextFieldtype.mail.rawValue})?.text = currentBasicUser.mail
        textFields.first(where: { $0.tag == TextFieldtype.dateOfBirth.rawValue})?.text = currentBasicUser.dateOfBirth
        
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
    
    @IBAction private func saveButtonAction(_ sender: UIButton) {
        var currentUser: BasicProfileModel = BasicProfileModel()
        
        guard let name = textFields.first(where: { $0.tag == TextFieldtype.name.rawValue})?.text,
                let surname = textFields.first(where: { $0.tag == TextFieldtype.surname.rawValue})?.text,
                let country = textFields.first(where: { $0.tag == TextFieldtype.country.rawValue})?.text,
                let city = textFields.first(where: { $0.tag == TextFieldtype.city.rawValue})?.text,
                let mail = textFields.first(where: { $0.tag == TextFieldtype.mail.rawValue})?.text,
                let dateOfBirth = textFields.first(where: { $0.tag == TextFieldtype.dateOfBirth.rawValue})?.text else {return}
        
        currentUser.name = name
        currentUser.surname = surname
        currentUser.country = country
        currentUser.city = city
        currentUser.mail = mail
        currentUser.dateOfBirth = dateOfBirth
        
        delegate?.getBasicAditUser(basicUser: currentUser)
    }
}
