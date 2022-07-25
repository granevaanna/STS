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
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    
    private var dataSource: [UserStatus] = []
    private var currentStatus: UserStatus = .online
    private var isOpenStatusList: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentPhoneNumber = FirebaseManager.getPhoneNumber(){
            phoneNumberLabel.text = currentPhoneNumber
        }
        
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
    
    private func showAlertController(message: String, cancelButtonTittle: String, okButtonTittle: String, completion: @escaping (UIAlertAction) -> Void){
        let alertController = UIAlertController(title: "Status Global", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: cancelButtonTittle, style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: okButtonTittle, style: .default, handler: {ok in
            completion(ok)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    private func showProfileViewController(){
        let profileViewController = ProfileViewController()
        profileViewController.delegate = self
        profileViewController.modalTransitionStyle = .coverVertical
        profileViewController.modalPresentationStyle = .fullScreen
        present(profileViewController, animated: true, completion: nil)
    }
    
    @IBAction private func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction private func logOutButtonAction(_ sender: UIButton) {
        showAlertController(message: "Вы уверены, что хотите выйти?", cancelButtonTittle: "Нет", okButtonTittle: "Да") {[weak self] ok in
            guard let self = self else { return }
            do{
                try Auth.auth().signOut()
                self.showStartViewController()
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
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
        if indexPath.row < dataSource.count{
            if isOpenStatusList {
                switch dataSource[indexPath.row] {
                case .busy:
                    showAlertController(message: "Когда режим  \(dataSource[indexPath.row].rawValue) включен, вы не будете получать никаких уведомлений.", cancelButtonTittle: "Отменить", okButtonTittle: "Продолжить") {[weak self] ok in
                        guard let self = self else {return}
                        self.isOpenStatusList.toggle()
                        self.currentStatus = self.dataSource[indexPath.row]
                        self.dataSource.remove(at: indexPath.row)
                        self.dataSource.insert(self.currentStatus, at: 0)
                        self.statusTableView.reloadData()
                    }
                case .invisible:
                    showAlertController(message: "В режиме  \(dataSource[indexPath.row].rawValue) чаты открываются без прочтения новых сообщений.", cancelButtonTittle: "Отменить", okButtonTittle: "Продолжить") {[weak self] ok in
                        guard let self = self else {return}
                        self.isOpenStatusList.toggle()
                        self.currentStatus = self.dataSource[indexPath.row]
                        self.dataSource.remove(at: indexPath.row)
                        self.dataSource.insert(self.currentStatus, at: 0)
                        self.statusTableView.reloadData()
                    }
                    case .online, .away:
                        isOpenStatusList.toggle()
                        currentStatus = dataSource[indexPath.row]
                        dataSource.remove(at: indexPath.row)
                        dataSource.insert(currentStatus, at: 0)
                        statusTableView.reloadData()
                    }
            } else {
                isOpenStatusList.toggle()
                statusTableView.reloadData()
            }
        } else {
            showProfileViewController()
        }
    }
}

//MARK: - ProfileViewControllerDelegate
extension MenuViewController: ProfileViewControllerDelegate{
    func backToContentViewController() {
        dismiss(animated: true)
    }
}
