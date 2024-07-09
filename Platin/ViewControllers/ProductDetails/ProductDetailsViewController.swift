//
//  ProductDetailsViewController.swift
//  Platin
//
//  Created by Reham Khalil on 09/07/2024.
//

import UIKit
import DropDown

class ProductDetailsViewController: BaseViewController {
    override var navigationHidingMode: BaseViewController.BarHidingMode{.alwaysVisible}
    
    @IBOutlet weak var sizeView: UIView!
    @IBOutlet weak var sizeTypeLabel: UIButton!
    @IBOutlet weak var sizeExpandeImage: UIButton!
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorTypeLabel: UIButton!
    @IBOutlet weak var colorExpandeImage: UIButton!
    
    @IBOutlet weak var quantityView: UIView!
    @IBOutlet weak var quantityTypeLabel: UIButton!
    @IBOutlet weak var quantityExpandeImage: UIButton!
    
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var sampleImagesCollectionView: UICollectionView!
    @IBOutlet weak var relatedProductsCollectionView: DynamicHeightCollectionView!
    @IBOutlet weak var specialoffersCollectionView: DynamicHeightCollectionView!
    
    let sizeViewDropDown = DropDown()
    let colorViewDropDown = DropDown()
    let quantityViewDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "".localized
        setupDropDown()
    }
    
    func setupDropDown(){
        Helper.setupDropDown(dropDownBtn: self.sizeView , dropDown: sizeViewDropDown, stringsArr: ["S".localized, "M".localized, "L".localized, "XL".localized]) {
            index , item in
            self.sizeTypeLabel.setTitle(item, for: .normal)
        }
        
        Helper.setupDropDown(dropDownBtn: self.colorView , dropDown: colorViewDropDown, stringsArr: ["Red".localized,"Black".localized, "White".localized]) {
            index , item in
            self.colorTypeLabel.setTitle(item, for: .normal)
        }
        
        Helper.setupDropDown(dropDownBtn: self.quantityView , dropDown: quantityViewDropDown, stringsArr: ["1 piece".localized,"2 piece".localized, "3 piece".localized]) {
            index , item in
            self.quantityTypeLabel.setTitle(item, for: .normal)
        }
        
    }
    
    override func connectActions(){
        [sizeView, sizeExpandeImage,sizeTypeLabel].forEach{
            $0?.UIViewAction {
                [weak self] in
                self?.sizeViewDropDown.show()
            }
        }
        
        [colorView, colorExpandeImage,colorTypeLabel].forEach{
            $0?.UIViewAction {
                [weak self] in
                self?.colorViewDropDown.show()
            }
        }
        
        [quantityView, quantityExpandeImage,quantityTypeLabel].forEach{
            $0?.UIViewAction {
                [weak self] in
                self?.quantityViewDropDown.show()
            }
        }
        
    }
    
    
    
    override func setupUI() {
        sampleImagesCollectionView.delegate = self
        sampleImagesCollectionView.dataSource = self
        sampleImagesCollectionView.register(ProductSampleCollectionViewCell.self)
        
        relatedProductsCollectionView.delegate = self
        relatedProductsCollectionView.dataSource = self
        relatedProductsCollectionView.register(ProductCollectionViewCell.self)
        
        specialoffersCollectionView.delegate = self
        specialoffersCollectionView.dataSource = self
        specialoffersCollectionView.register(SpecialOffersCollectionViewCell.self)
    }
}
extension ProductDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sampleImagesCollectionView {
            let cell: ProductSampleCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
        else if collectionView == relatedProductsCollectionView {
            let cell: ProductCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if collectionView == specialoffersCollectionView{
            let cell: SpecialOffersCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == specialoffersCollectionView{ return 0}
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == specialoffersCollectionView{ return 0}
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sampleImagesCollectionView {
            return CGSize(width: collectionView.bounds.width / 3.1, height: 100)
        }else if collectionView == relatedProductsCollectionView {
            return CGSize(width: collectionView.bounds.width / 2.2, height: 250)
        }else if collectionView == specialoffersCollectionView{
            return CGSize(width: collectionView.bounds.width - 50, height: 120)
        }
        return CGSize()
    }
}
