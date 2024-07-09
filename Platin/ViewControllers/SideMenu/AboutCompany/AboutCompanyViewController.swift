//
//  AboutCompanyViewController.swift
//  Platin
//
//  Created by Reham Khalil on 09/07/2024.
//

import UIKit

class AboutCompanyViewController: BaseViewController {
    override var navigationHidingMode: BaseViewController.BarHidingMode{.alwaysVisible}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About Company"
    }

}
