//
//  MediaCenterViewController.swift
//  Platin
//
//  Created by Reham Khalil on 09/07/2024.
//

import UIKit

class MediaCenterViewController: BaseViewController {
    override var navigationHidingMode: BaseViewController.BarHidingMode{.alwaysVisible}
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var videosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Media Center".localized
        setupCollectionView()
    }
    
    private func setupCollectionView(){
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(ImagesMediaCenterCollectionViewCell.self)
     
        videosCollectionView.delegate = self
        videosCollectionView.dataSource = self
        videosCollectionView.register(VideosMediaCenterCollectionViewCell.self)
    }
}

extension MediaCenterViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imagesCollectionView{
            let cell: ImagesMediaCenterCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.UIViewAction {
                [weak self] in
                let vc = MediaCenterDetailsViewController.loadFromNib()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        }
        
        let cell: VideosMediaCenterCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imagesCollectionView{
            return CGSize(width: collectionView.bounds.width / 2.3, height: 230)
        }
        return CGSize(width: collectionView.bounds.width / 2.3, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
