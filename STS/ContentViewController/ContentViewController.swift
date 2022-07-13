//
//  ChatsViewController.swift
//  STS
//
//  Created by Анна Гранёва on 12.07.22.
//

import UIKit
import FirebaseAuth

final class ContentViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
    }
    
    
    private func generateTabBar(){
        viewControllers = [generateViewController(viewController: CallsViewController(),
                                                  title: "Звонки",
                                                  image: UIImage(systemName: "phone.fill")),
                           generateViewController(viewController: ChatsViewController(),
                                                  title: "Чаты",
                                                  image: UIImage(systemName: "message.fill")),
                           generateViewController(viewController: ContactsViewController(),
                                                  title: "Контакты",
                                                  image: UIImage(systemName: "wallet.pass.fill")),
                           generateViewController(viewController: MyViewController(),
                                                  title: "Моё",
                                                  image: UIImage(systemName: "wand.and.stars"))]
    }
    private func generateViewController(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController{
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    
//    private func showStartViewController(){
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let startViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//        startViewController.modalPresentationStyle = .fullScreen
//        startViewController.modalTransitionStyle = .crossDissolve
//        present(startViewController, animated: true, completion: nil)
//    }
//
//    @IBAction private func logOutButtonAction(_ sender: UIButton) {
//        do{
//            try Auth.auth().signOut()
//            showStartViewController()
//        } catch let signOutError as NSError {
//            print("Error signing out: %@", signOutError)
//          }
//    }
}
