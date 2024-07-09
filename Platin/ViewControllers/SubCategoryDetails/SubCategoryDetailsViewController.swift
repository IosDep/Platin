//
//  SubCategoryDetailsViewController.swift
//  Platin
//
//  Created by Reham Khalil on 09/07/2024.
//

import UIKit
import ViewAnimator
import DropDown

class SubCategoryDetailsViewController: BaseViewController {
    override var navigationHidingMode: BaseViewController.BarHidingMode{.alwaysVisible}
    
    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var sortTypeLabel: UIButton!
    @IBOutlet weak var expandeImage: UIButton!
    
    @IBOutlet weak var collectionView: DynamicHeightCollectionView!
    
    let sortViewDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSortViewDropDown()
        fadeInCells()
        title = "Daily Electrical"
    }
    
    override func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCollectionViewCell.self)
    }
    
    
    
    override func connectActions() {
        [sortView, expandeImage,sortTypeLabel].forEach{
            $0?.UIViewAction {
                [weak self] in
                self?.sortViewDropDown.show()
            }
        }
    }
    
    private func fadeInCells() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.collectionView.reloadData()
            
            self.collectionView?.performBatchUpdates({
                let animations = [AnimationType.from(direction: .top, offset: 150.0)]
                UIView.animate(views: self.collectionView.visibleCells(in: 0),
                               animations: animations,
                               duration: 4.0,
                               usingSpringWithDamping: 0.4,
                               initialSpringVelocity: 0,
                               options: [.allowUserInteraction])
            }, completion: nil)
        }
    }
    
    func setupSortViewDropDown() {
        Helper.setupDropDown(dropDownBtn: self.sortView , dropDown: sortViewDropDown, stringsArr: ["Ear protection".localized,"Head protection".localized]) {
            index , item in
            self.sortTypeLabel.setTitle(item, for: .normal)
        }
    }
}

extension SubCategoryDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.UIViewAction {
            [weak self] in
            let vc = ProductDetailsViewController.loadFromNib()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5 , left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2.1, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}
