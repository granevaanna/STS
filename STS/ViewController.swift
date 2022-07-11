//
//  ViewController.swift
//  STS
//
//  Created by Анна Гранёва on 12.07.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showStartAnimation()
    }
    
    private func showStartAnimation(){
        UIView.animate(withDuration: 0.5, delay: 2, options: .curveLinear) {
            self.logoImageView.transform = self.logoImageView.transform.rotated(by: CGFloat(Double.pi / 2))
        } completion: { finished in
            self.loginButton.isHidden = false
        }
    }
    
    
    @IBAction private func loginButtonAction(_ sender: Any) {
    }
}

