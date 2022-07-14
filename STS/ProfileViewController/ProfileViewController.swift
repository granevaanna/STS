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

class ProfileViewController: UIViewController {

    weak var delegate: ProfileViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
        delegate?.backToContentViewController()
    }
}
