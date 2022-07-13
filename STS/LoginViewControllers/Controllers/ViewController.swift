//
//  ViewController.swift
//  STS
//
//  Created by Анна Гранёва on 12.07.22.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showStartAnimation()
    }
    
    private func showContentViewController(){
        let contentViewController = ContentViewController()
        contentViewController.modalPresentationStyle = .fullScreen
        contentViewController.modalTransitionStyle = .crossDissolve
        present(contentViewController, animated: true, completion: nil)
    }
    
    private func showStartAnimation(){
        UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveLinear) {
            self.logoImageView.transform = self.logoImageView.transform.rotated(by: CGFloat(Double.pi / 2))
        } completion: { [weak self] finished in
            guard let self = self else {return}
            if Auth.auth().currentUser?.uid != nil{
                self.showContentViewController()
            } else {
                self.loginButton.isHidden = false
                self.rotatedLogoImageToLeft()
            }
        }
    }
    private func rotatedLogoImageToLeft(){
        UIView.animate(withDuration: 0.5, delay: 0.1, animations: {
            self.logoImageView.transform = self.logoImageView.transform.rotated(by: CGFloat(-Double.pi / 2))
        }, completion: nil)
    }
    
    
    @IBAction private func loginButtonAction(_ sender: Any) {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        loginViewController.modalTransitionStyle = .crossDissolve
        present(loginViewController, animated: true, completion: nil)
    }
}



