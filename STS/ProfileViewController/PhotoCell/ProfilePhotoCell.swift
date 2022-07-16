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

    func setup(photo: UIImage, fullName: String, phoneNumber: String){
        photoImage.image = photo
        nameLabel.text = fullName
        phoneNumberLabel.text = phoneNumber
    }
}
