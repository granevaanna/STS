//
//  CallsViewController.swift
//  STS
//
//  Created by Анна Гранёва on 13.07.22.
//

import UIKit

class CallsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    private func showMenuViewController(){
        let menuViewController = MenuViewController()
        menuViewController.modalPresentationStyle = .fullScreen
        menuViewController.modalTransitionStyle = .coverVertical
        present(menuViewController, animated: true, completion: nil)
        
    }
    
  
    @IBAction func menuButtonAction(_ sender: UIButton) {
        showMenuViewController()
    }
}
