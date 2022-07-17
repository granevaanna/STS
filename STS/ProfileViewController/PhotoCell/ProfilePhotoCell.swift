//
//  ProfilePhotoCell.swift
//  STS
//
//  Created by Анна Гранёва on 16.07.22.
//

import UIKit

class ProfilePhotoCell: UITableViewCell {
    static let identifier = "kProfilePhotoCell"
    
    @IBOutlet private weak var photoImage: UIImageView!
    @IBOutlet private weak var addPhotoButton: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImage.layer.cornerRadius = photoImage.frame.width / 2
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.width / 2
    }

    func setup(profileType: ProfileType, photo: UIImage?, fullName: String, phoneNumber: String){
        switch profileType {
        case .basic:
            guard let photo = photo else { return }
            photoImage.image = photo
            addPhotoButton.isHidden = false
            nameLabel.text = fullName
            phoneNumberLabel.isHidden = false
            phoneNumberLabel.text = phoneNumber
        case .anonym:
            photoImage.image = UIImage(systemName: "person.fill.questionmark")
            addPhotoButton.isHidden = true
//            nameLabel.text = nickname
            phoneNumberLabel.isHidden = true
        }
    }
}
