//
//  MenuViewController.swift
//  STS
//
//  Created by Анна Гранёва on 13.07.22.
//

import UIKit
import FirebaseAuth

enum UserStatus: String{
    case online = "В сети"
    case away = "Нет на месте"
    case busy = "Не беспокоить"
    case invisible = "Невидимка"
}

class MenuViewController: UIViewController {
    @IBOutlet private weak var statusTableView: UITableView!
    private var dataSource: [UserStatus] = []
    private var currentStatus: UserStatus = .online
    private var isOpenStatusList: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusTableView.dataSource = self
        statusTableView.delegate = self
        statusTableView.register(UINib(nibName: "StatusTableViewCell", bundle: nil), forCellReuseIdentifier: StatusTableViewCell.identifier)
    }
    
        private func showStartViewController(){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let startViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            startViewController.modalPresentationStyle = .fullScreen
            startViewController.modalTransitionStyle = .crossDissolve
            present(startViewController, animated: true, completion: nil)
        }
    
    @IBAction private func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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

//MARK: - UITableViewDataSource, UITableViewDelegate
extension MenuViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isOpenStatusList{
            dataSource = [.online, .away, .busy, .invisible]
            return dataSource.count + 1
        } else {
            dataSource = [currentStatus]
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = statusTableView.dequeueReusableCell(withIdentifier: StatusTableViewCell.identifier, for: indexPath) as! StatusTableViewCell
        if indexPath.row == dataSource.count{
            cell.setupForProfileCell()
        } else {
            cell.setup(currentStatus: currentStatus, status: dataSource[indexPath.row],indexPath: indexPath, isOpenStatusList: isOpenStatusList)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != dataSource.count {
            isOpenStatusList.toggle()
            currentStatus = dataSource[indexPath.row]
            dataSource.remove(at: indexPath.row)
            dataSource.insert(currentStatus, at: 0)
        }
        statusTableView.reloadData()
    }
}
