//
//  CallsView.swift
//  STS
//
//  Created by Анна Гранёва on 14.07.22.
//

import UIKit

protocol CallsViewScrollDelegate: AnyObject {
    func didScrollto(indexPath: IndexPath)
}

final class CallsView: UIView{
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var callsCollectionView: UICollectionView!
    
    private var callsDataSourse: [String] = ["First", "Second"]
    
    weak var delegate: CallsViewScrollDelegate?
    
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
        callsCollectionView.delegate = self
        callsCollectionView.dataSource = self
        callsCollectionView.register(UINib(nibName: "CallsCollectionCell", bundle: nil), forCellWithReuseIdentifier: CallsCollectionCell.identifier)
    }
    
    func scrollTo(indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            self?.callsCollectionView.scrollToItem(at: indexPath,
                                                  at: .centeredHorizontally,
                                                  animated: false)
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension CallsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return callsDataSourse.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = callsCollectionView.dequeueReusableCell(withReuseIdentifier: CallsCollectionCell.identifier, for: indexPath) as! CallsCollectionCell
        cell.setup(text: callsDataSourse[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width, height: contentView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row)
        delegate?.didScrollto(indexPath: indexPath)
    }
}

