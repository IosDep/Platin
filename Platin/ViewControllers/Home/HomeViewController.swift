//
//  HomeViewController.swift
//  Platin
//
//  Created by Reham Khalil on 04/07/2024.
//

import UIKit
import ViewAnimator

class HomeViewController: BaseViewController {
    override var navigationHidingMode: BaseViewController.BarHidingMode{.alwaysHidden}
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fadeInCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.hiddenNavigation(isHidden: true)
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
                let animations = [AnimationType.vector((CGVector(dx: 0, dy: 150)))]
                UIView.animate(views: self.collectionView.visibleCells(in: 0),
                               animations: animations,
                               duration: 3.5, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [.allowUserInteraction])
            })
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
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
