//
//  CategoyDetailsViewController.swift
//  Platin
//
//  Created by Reham Khalil on 09/07/2024.
//

import UIKit
import ViewAnimator

class CategoyDetailsViewController: BaseViewController {
    override var navigationHidingMode: BaseViewController.BarHidingMode{.alwaysVisible}
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fadeInCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.hiddenNavigation(isHidden: false)
    }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(HomeCollectionViewCell.self)
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

    
    override func connectActions() {
        
    }
    
}

extension CategoyDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.UIViewAction {
            [weak self] in
            let vc = SubCategoryDetailsViewController.loadFromNib()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
    }
}
