//
//  StatusTableViewCell.swift
//  STS
//
//  Created by Анна Гранёва on 13.07.22.
//

import UIKit

class StatusTableViewCell: UITableViewCell {
    static let identifier = "StatusTableViewCell"
    
    @IBOutlet private weak var statusImage: UIImageView!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var arrowImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(currentStatus: UserStatus, status: UserStatus, indexPath: IndexPath, isOpenStatusList: Bool){
        if currentStatus == status{
            statusImage.image = UIImage(systemName: "circle.inset.filled")
        } else {
            statusImage.image = UIImage(systemName: "circle")
        }
        
        switch status {
        case .online:
            statusImage.tintColor = .green
        case .away:
            statusImage.tintColor = .orange
        case .busy:
            statusImage.tintColor = .red
        case .invisible:
            statusImage.tintColor = .gray
        }
        
        statusLabel.text = status.rawValue
        
        if indexPath.row == 0{
            arrowImage.isHidden = false
            if isOpenStatusList{
                arrowImage.image = UIImage(systemName: "arrowtriangle.up.fill")
            } else {
                arrowImage.image = UIImage(systemName: "arrowtriangle.down.fill")
            }
        } else {
            arrowImage.isHidden = true
        }
    }
    
    func setupForProfileCell(){
        statusImage.image = UIImage(systemName: "person.crop.circle")
        statusImage.tintColor = .darkGray
        statusLabel.text = "Профиль"
        arrowImage.isHidden = true
    }
}
