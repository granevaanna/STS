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
                                                  tag: 1,
                                                  title: "Звонки",
                                                  image: UIImage(systemName: "phone.fill")),
                           generateViewController(viewController: ChatsViewController(),
                                                  tag: 2,
                                                  title: "Чаты",
                                                  image: UIImage(systemName: "message.fill")),
                           generateViewController(viewController: ContactsViewController(),
                                                  tag: 3,
                                                  title: "Контакты",
                                                  image: UIImage(systemName: "wallet.pass.fill")),
                           generateViewController(viewController: MyViewController(),
                                                  tag: 4,
                                                  title: "Моё",
                                                  image: UIImage(systemName: "wand.and.stars"))]
        tabBar.backgroundColor = .white
    }
    
    private func generateViewController(viewController: UIViewController, tag: Int, title: String, image: UIImage?) -> UIViewController{
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        viewController.tabBarItem.tag = tag
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
