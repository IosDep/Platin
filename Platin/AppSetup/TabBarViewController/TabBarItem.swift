//
//  TabBarItem.swift
//  CARDIZERR
//
//  Created by Reham Abu hadba on 10/02/2023.
//

import UIKit

final class TabBarItem: UITabBarItem {

    // MARK: Properties

    internal var tintColor: UIColor?

    // MARK: Init

    convenience init(title: String?, image: UIImage?, tag: Int, tintColor: UIColor) {
        self.init()

        super.title = title
        super.image = image
        super.tag = tag
        self.tintColor = tintColor
        
    }

    convenience init(title: String?, image: UIImage?, selectedImage: UIImage?, tintColor: UIColor)  {
        self.init()

        super.title = title
        super.image = image
        super.selectedImage = selectedImage
        self.tintColor = tintColor
    }

}
