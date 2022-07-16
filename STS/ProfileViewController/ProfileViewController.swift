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
            let cell = profileTableView.dequeueReusableCell(withIdentifier: ProfilePhotoCell.identifier, for: indexPath)
            return cell
        case .buttonsTypeProfileCell:
            let cell = profileTableView.dequeueReusableCell(withIdentifier: ButtonsTypeProfileCell.identifier, for: indexPath)
            return cell
        case .typeProfileCell:
            let cell = profileTableView.dequeueReusableCell(withIdentifier: BasicProfileCell.identifier, for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath.row] {
        case .photoCell:
            return CGFloat(300)
        case .buttonsTypeProfileCell:
            return CGFloat(30)
        case .typeProfileCell:
            return CGFloat(800)
        }
    }
}
