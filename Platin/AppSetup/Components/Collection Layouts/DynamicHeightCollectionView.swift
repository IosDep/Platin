//
//  DynamicHeightCollectionView.swift
//  Cardizerr Admin
//
//  Created by yazed raed on 10/08/2023.
//

import UIKit

class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if  !__CGSizeEqualToSize(bounds.size,self.intrinsicContentSize){
            self.invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}


class DynamicHeightTableView: UITableView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if  !__CGSizeEqualToSize(bounds.size,self.intrinsicContentSize){
            self.invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

