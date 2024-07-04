//
//  SectionBoundary+Title.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 21/02/2023.
//

import UIKit

extension NSCollectionLayoutBoundarySupplementaryItem {
    static func title() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))

        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSize,
                                                           elementKind: UICollectionView.elementKindSectionHeader,
                                                    alignment: .top)
    }
}
