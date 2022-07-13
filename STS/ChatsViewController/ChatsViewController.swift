//
//  ChatsViewController.swift
//  STS
//
//  Created by Анна Гранёва on 12.07.22.
//

import UIKit
import FirebaseAuth

final class ChatsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func showStartViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let startViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        startViewController.modalPresentationStyle = .fullScreen
        startViewController.modalTransitionStyle = .crossDissolve
        present(startViewController, animated: true, completion: nil)
    }
    
    @IBAction private func logOutButtonAction(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            showStartViewController()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
          }
    }
}
