//
//  ViewController.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/6/27.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: INFBaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, INFSearchNavViewDelegate {

    let cellID: String = "cellID"
    let themCellID = "themCellID"
    let productCellID = "productCellID"
    var cellHeight: CGFloat = 100
    var navView :INFSearchNavView!
    var resultView: UIView!
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    let themeImgArray: Array = ["theme_1", "theme_2"]
    let productImgArray: Array = ["product_1",
                                  "product_2",
                                  "product_3",
                                  "product_4",
                                  "product_5",
                                  "product_6",]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        
        navView = INFSearchNavView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        navView.delegate = self
        
        
        
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(INFThemeCell.self, forCellWithReuseIdentifier: themCellID)
        collectionView.register(INFPtoductCell.self, forCellWithReuseIdentifier: productCellID)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        
        resultView = UIView()
        resultView.backgroundColor = UIColor.white
        self.view.addSubview(resultView)
        view.insertSubview(resultView, aboveSubview: collectionView)
        resultView.isHidden = true
        
        resultView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.addSubview(navView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navView.removeFromSuperview()
    }

}

extension ViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        case 2:
            return 6
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
//        case 0:
//            let cell: INFThemeCell = collectionView.dequeueReusableCell(withReuseIdentifier: themCellID, for: indexPath) as! INFThemeCell
//            cell.backImageView.image = UIImage(named: themeImgArray[indexPath.row])
//            cell.titleLabel.text = "我的主题"
//            return cell
        case 0:
            let cell: INFThemeCell = collectionView.dequeueReusableCell(withReuseIdentifier: themCellID, for: indexPath) as! INFThemeCell
            cell.contentView.backgroundColor = UIColor.blue
            cell.titleLabel.text = "定制\nHid Dikeng"
            cell.layer.cornerRadius = 2
            cell.layer.masksToBounds = true
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            cell.layer.cornerRadius = 2
            cell.layer.masksToBounds = true
            cell.backgroundColor = UIColor.purple
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellID, for: indexPath) as! INFPtoductCell
            cell.iconImgView.image = UIImage(named: productImgArray[indexPath.row])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            cell.backgroundColor = UIColor.blue
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            let width = (collectionView.frame.size.width - 15*2 - 15)/2
            return CGSize(width: width, height: 80)
        case 1:
            let width = (collectionView.frame.size.width - 15*2)
            return CGSize(width: width, height: cellHeight)
        default:
            let width = (collectionView.frame.size.width - 15*2 - 15)/2
            return CGSize(width: width, height: width+50)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
//        case 0:
//            let cell = collectionView.cellForItem(at: indexPath) as! INFThemeCell
//
//            let animtor = INFImageTransition()
//            animtor.duration = 0.5
//            animtor.imageViewRect = CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: kThemeImageHeight)
//            animtor.transitionimageView = cell.backImageView
//            if let navgation: INFNavigationController = self.navigationController as? INFNavigationController{
//
////                let vc = INFProductInfoViewController()
////                vc.hidesBottomBarWhenPushed = true
////                navgation.pushToVC(viewControllrt: vc, animator: animtor)
//            }
//            break
        case 0:
            let cell = collectionView.cellForItem(at: indexPath)
            let sheetView = INFThemeSheet.sheetWithshotView(view: cell!)
            sheetView.showSheet()

            break
        case 1:
            
            if cellHeight == 200 {
                cellHeight = 100
            }else{
                cellHeight = 200
            }
            UIView.animate(withDuration: 0.4) {
                collectionView.performBatchUpdates({
                    self.collectionView.reloadData()
                }, completion: { (_) in

                })
            }
            break
        case 2:
            let cell = collectionView.cellForItem(at: indexPath) as! INFPtoductCell
            let animtor = INFImageTransition()
            animtor.duration = 0.5
            animtor.imageViewRect = CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: kProductImageHeight)
            animtor.transitionimageView = cell.iconImgView
            let vc = INFProductInfoViewController()
            vc.hidesBottomBarWhenPushed = true
            self.animtorNavigationController?.pushToVC(viewControllrt: vc, animator: animtor)
            break
        default: break
            
        }

        
    }
    
    //MARK: 开始搜索
    func searchBarDidEnd() {
        let animation = CATransition()
        animation.type = .fade
        animation.duration = 0.3
        
        resultView.layer.add(animation, forKey: "")
        resultView.isHidden = true
    }
    
    //MARK: 结束搜索
    func searchBarDidBegin() {
        let animtion = CATransition()
        animtion.type = .fade
        animtion.duration = 0.3
        
        resultView.layer.add(animtion, forKey: "")
        resultView.isHidden = false
    }
}
