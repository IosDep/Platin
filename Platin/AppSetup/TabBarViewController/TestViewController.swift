//
//  TestViewController.swift
//  Rayhan
//
//  Created by Reham Khalil on 02/06/2024.


import UIKit

class TestViewController: BaseViewController {
    override var navigationHidingMode: BaseViewController.BarHidingMode{.alwaysVisible}
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "test test".localized
    }
    @IBAction func clickTest(_ sender: Any) {
        let vc = TestViewController.loadFromNib()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
