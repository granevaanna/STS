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
    
    private func showChatsViewController(){
        let chatsViewController = ChatsViewController()
        chatsViewController.modalPresentationStyle = .fullScreen
        chatsViewController.modalTransitionStyle = .crossDissolve
        present(chatsViewController, animated: true, completion: nil)
    }
    
    private func showStartAnimation(){
        UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveLinear) {
            self.logoImageView.transform = self.logoImageView.transform.rotated(by: CGFloat(Double.pi / 2))
        } completion: { finished in
//            if Auth.auth().currentUser?.uid != nil{
//                self.showChatsViewController()
//            } else {
//                self.loginButton.isHidden = false
//                self.rotatedLogoImageToLeft()
//            }
            self.loginButton.isHidden = false
            self.rotatedLogoImageToLeft()
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



