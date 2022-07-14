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
    private var dataSource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.dataSource = self
        profileTableView.delegate = self
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
        return UITableViewCell()
    }
}
