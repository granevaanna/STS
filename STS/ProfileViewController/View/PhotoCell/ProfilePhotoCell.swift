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

    func setup(profileType: ProfileType, currentUser: ProfileModel){
        switch profileType {
        case .basic:
            addPhotoButton.isHidden = false
            phoneNumberLabel.isHidden = false
            if let photo = currentUser.image{
                photoImage.image = photo
            }
            nameLabel.text = currentUser.fullName
            phoneNumberLabel.text = currentUser.phoneNumber
        case .anonym:
            photoImage.image = UIImage(systemName: "person.fill.questionmark")
            addPhotoButton.isHidden = true
            phoneNumberLabel.isHidden = true
            if let nickname = currentUser.nickname{
                nameLabel.text = nickname
            }
        }
    }
}
