//
//  TrademarksViewController.swift
//  Platin
//
//  Created by Reham Khalil on 09/07/2024.
//

import UIKit
import ViewAnimator
class TrademarksViewController: BaseViewController {
    override var navigationHidingMode: BaseViewController.BarHidingMode{.alwaysVisible}
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trademarks"
        fadeInCells()
        setupCollectionView()
    }

    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrademarksCollectionViewCell.self)
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
}

extension TrademarksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TrademarksCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2.1, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5 , left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}
