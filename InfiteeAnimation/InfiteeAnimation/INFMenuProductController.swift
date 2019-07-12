//
//  INFMenuProductController.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/10.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

protocol INFMenuProductControllerDelegate: NSObjectProtocol {
    func productVCselectAtIndex(index: Int) -> Void
}

class INFMenuProductController: INFBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    let productCellID = "productCellID"
    let headerViewID = "headerViewID"
    var collectionView: UICollectionView!
    var dataArray: [INFMenuModel] = []
    weak var delegate: INFMenuProductControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    public func setupData(menuArray: [INFMenuModel]) -> Void {
        dataArray = menuArray
        collectionView.reloadData()
    }
    
    func setupUI() -> Void {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.register(UINib.init(nibName: "INFMenuProductCell", bundle: nil), forCellWithReuseIdentifier: productCellID)
        
        collectionView.register(INFProductHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerViewID)
        
    }
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellID, for: indexPath) as! INFMenuProductCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewID, for: indexPath) as! INFProductHeaderView
            headerView.titleLabel.text = dataArray[indexPath.section].menuName
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.width - 15 * 2 - 8)/2
        
        return CGSize(width: width, height: width+70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.width, height: 44)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleArray: [IndexPath] =  collectionView.indexPathsForVisibleSupplementaryElements(ofKind: UICollectionView.elementKindSectionHeader)
        if visibleArray.count > 0 {
            let path = visibleArray[0]
            print("path = \(path.section)")
            if self.delegate != nil {
                self.delegate?.productVCselectAtIndex(index: path.section)
            }
        }
    }
    
}

extension INFMenuProductController {
    public func scrollToSection(index: Int) -> Void {
        let cellIndexPath = IndexPath(row: 0, section: index)
        collectionView.scrollToItem(at: cellIndexPath, at: .centeredVertically, animated: true)
    }
}
