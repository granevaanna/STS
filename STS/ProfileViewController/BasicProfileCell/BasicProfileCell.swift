//
//  BasicProfileCell.swift
//  STS
//
//  Created by Анна Гранёва on 16.07.22.
//

import UIKit

class BasicProfileCell: UITableViewCell {
    static let identifier = "kBasicProfileCell"
    
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private var labels: [UILabel]!
    @IBOutlet private var textFields: [UITextField]!
    @IBOutlet private weak var saveButton: UIButton!
    
    private enum textFieldtype: Int{
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
        
    }
}