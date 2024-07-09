//
//  SideMenuViewController.swift
//  Platin
//
//  Created by Reham Khalil on 09/07/2024.
//

import UIKit

class SideMenuViewController: BaseViewController {
    override var navigationHidingMode: BaseViewController.BarHidingMode{.alwaysHidden}
    
    @IBOutlet weak var backButtonImage: UIImageView!
    @IBOutlet weak var aboutCompany: UILabel!
    @IBOutlet weak var mediaCenter: UILabel!
    @IBOutlet weak var certificates: UILabel!
    @IBOutlet weak var trademarks: UILabel!
    @IBOutlet weak var ourCompanies: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func connectActions() {
        backButtonImage.UIViewAction {
            [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        aboutCompany.UIViewAction {
            [weak self] in
            let vc = AboutCompanyViewController.loadFromNib()
            self?.navigationController?.pushViewController(vc, animated: true )
        }  
        
        mediaCenter.UIViewAction {
            [weak self] in
            let vc = MediaCenterViewController.loadFromNib()
            self?.navigationController?.pushViewController(vc, animated: true )
        }
        
        certificates.UIViewAction {
            [weak self] in
            let vc = CertificatesViewController.loadFromNib()
            self?.navigationController?.pushViewController(vc, animated: true )
        }
        
        trademarks.UIViewAction {
            [weak self] in
            let vc = TrademarksViewController.loadFromNib()
            self?.navigationController?.pushViewController(vc, animated: true )
        }
        
        ourCompanies.UIViewAction {
            [weak self] in
            let vc = OurCompaniesViewController.loadFromNib()
            self?.navigationController?.pushViewController(vc, animated: true )
        }
    }
}
