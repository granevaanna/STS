//
//  CallsViewController.swift
//  STS
//
//  Created by Анна Гранёва on 13.07.22.
//

import UIKit
import SwiftUI

class CallsViewController: UIViewController {
//    @IBOutlet private weak var tabBarView: TabBarView!
    @IBOutlet private weak var tabBarCollectionView: UICollectionView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var callsView: CallsView!
    
    private var tabBarDataSourse: [TabBarCallsModel] = [TabBarCallsModel(tabBarName: "STATUS"), TabBarCallsModel(tabBarName: "ВНЕШНИЕ")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionSettings()
        callsView.delegate = self
    }
    
    private func setupCollectionSettings(){
        tabBarCollectionView.delegate = self
        tabBarCollectionView.dataSource = self
        tabBarCollectionView.register(UINib(nibName: "TabBarCollectionCell", bundle: nil), forCellWithReuseIdentifier: TabBarCollectionCell.identifier)
        tabBarDataSourse[0].isSelect = true
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

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension CallsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabBarDataSourse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tabBarCollectionView.dequeueReusableCell(withReuseIdentifier: TabBarCollectionCell.identifier, for: indexPath) as! TabBarCollectionCell
        cell.setup(tabBarCallsModel: tabBarDataSourse[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: tabBarCollectionView.frame.width / 2, height: tabBarCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        for i in 0...tabBarDataSourse.count - 1{
            tabBarDataSourse[i].isSelect = false
        }
        tabBarDataSourse[indexPath.row].isSelect = true
        tabBarCollectionView.reloadData()
        
        callsView.scrollTo(indexPath: indexPath)
    }
}

//MARK: - CallsViewScrollDelegate
extension CallsViewController: CallsViewScrollDelegate{
    func didScrollto(indexPath: IndexPath) {
        for i in 0...tabBarDataSourse.count - 1{
            tabBarDataSourse[i].isSelect = false
        }
        tabBarDataSourse[indexPath.row].isSelect = true
        tabBarCollectionView.reloadData()
    }
}
