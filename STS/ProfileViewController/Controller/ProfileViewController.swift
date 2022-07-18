//
//  ProfileViewController.swift
//  STS
//
//  Created by Анна Гранёва on 14.07.22.
//

import UIKit

protocol ProfileViewControllerDelegate: AnyObject{
    func backToContentViewController()
}

final class ProfileViewController: UIViewController {
    weak var delegate: ProfileViewControllerDelegate?
    @IBOutlet weak var profileTableView: UITableView!
    private var profileType: ProfileType = .basic
    private var currentUser: ProfileModel = ProfileModel()
    
    private enum CellTypes{
        case photoCell
        case buttonsTypeProfileCell
        case typeProfileCell
    }
    
    private var dataSource: [CellTypes] = [.photoCell, .buttonsTypeProfileCell, .typeProfileCell]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.dataSource = self
        profileTableView.delegate = self
        profileTableView.register(UINib(nibName: "ProfilePhotoCell", bundle: nil), forCellReuseIdentifier: ProfilePhotoCell.identifier)
        profileTableView.register(UINib(nibName: "ButtonsTypeProfileCell", bundle: nil), forCellReuseIdentifier: ButtonsTypeProfileCell.identifier)
        profileTableView.register(UINib(nibName: "BasicProfileCell", bundle: nil), forCellReuseIdentifier: BasicProfileCell.identifier)
        profileTableView.register(UINib(nibName: "AnonymProfileCell", bundle: nil), forCellReuseIdentifier: AnonymProfileCell.identifier)
    }
    
    @IBAction private func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
        delegate?.backToContentViewController()
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
        case .photoCell:
            let cell = profileTableView.dequeueReusableCell(withIdentifier: ProfilePhotoCell.identifier, for: indexPath) as! ProfilePhotoCell
            cell.setup(profileType: profileType, currentUser: currentUser)
            cell.selectionStyle = .none
            return cell
        case .buttonsTypeProfileCell:
            let cell = profileTableView.dequeueReusableCell(withIdentifier: ButtonsTypeProfileCell.identifier, for: indexPath) as! ButtonsTypeProfileCell
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        case .typeProfileCell:
            switch profileType {
            case .basic:
                let cell = profileTableView.dequeueReusableCell(withIdentifier: BasicProfileCell.identifier, for: indexPath) as! BasicProfileCell
                cell.setup(currentUser: currentUser)
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            case .anonym:
                let cell = profileTableView.dequeueReusableCell(withIdentifier: AnonymProfileCell.identifier, for: indexPath) as! AnonymProfileCell
                cell.selectionStyle = .none
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath.row] {
        case .photoCell:
            return CGFloat(300)
        case .buttonsTypeProfileCell:
            return CGFloat(50)
        case .typeProfileCell:
            switch profileType {
            case .basic:
                return CGFloat(770)
            case .anonym:
                return CGFloat(570)
            }
        }
    }
}

//MARK: - ButtonsTypeProfileCellDelegate
extension ProfileViewController: ButtonsTypeProfileCellDelegate{
    func updateTableView(profileType: ProfileType) {
        self.profileType = profileType
        profileTableView.reloadData()
    }
}

//MARK: - BasicProfileCellDelegate
extension ProfileViewController: BasicProfileCellDelegate{
    func getAditUser(user: ProfileModel) {
        currentUser = user
        profileTableView.reloadData()
    }
    
    
}
