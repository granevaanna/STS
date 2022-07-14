//
//  TabBarView.swift
//  STS
//
//  Created by Анна Гранёва on 14.07.22.
//

import UIKit

final class TabBarView: UIView{
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var tabBarCollectionView: UICollectionView!
    
    private var tabBarDataSourse: [TabBarCallsModel] = [TabBarCallsModel(tabBarName: "STATUS"), TabBarCallsModel(tabBarName: "ВНЕШНИЕ")]
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }
        
        private func commonInit() {
            Bundle.main.loadNibNamed("\(type(of: self))", owner: self, options: nil)
            addSubview(contentView)
            contentView.frame = bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            setupCollectionSettings()
        }
    
    private func setupCollectionSettings(){
        tabBarCollectionView.delegate = self
        tabBarCollectionView.dataSource = self
        tabBarCollectionView.register(UINib(nibName: "TabBarCollectionCell", bundle: nil), forCellWithReuseIdentifier: TabBarCollectionCell.identifier)
        tabBarDataSourse[0].isSelect = true
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension TabBarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabBarDataSourse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tabBarCollectionView.dequeueReusableCell(withReuseIdentifier: TabBarCollectionCell.identifier, for: indexPath) as! TabBarCollectionCell
        cell.setup(tabBarCallsModel: tabBarDataSourse[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width / 2, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        for i in 0...tabBarDataSourse.count - 1{
            tabBarDataSourse[i].isSelect = false
        }
        tabBarDataSourse[indexPath.row].isSelect = true
        tabBarCollectionView.reloadData()
        
//        daysView.scrollTo(day: indexPath.row)
    }
}
