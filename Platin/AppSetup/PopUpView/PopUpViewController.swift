//
//  PopUpViewController.swift
//  CARDIZERR
//
//  Created by Osama Abu hdba on 12/04/2023.
//

import UIKit

enum PopUpTypes {
    case login
    case logout
    case deactivateAccount
    case block
    case commerical
    case housing
    case delete
}

protocol GeneralPopUpActionDelegate : AnyObject{
    func buttonActions(_ sender:PopUpViewController, actionType: PopUpTypes)
}


class PopUpViewController: BaseViewController {
    
    override var navigationHidingMode: BaseViewController.BarHidingMode {
        .alwaysHidden
    }
    
    @IBOutlet weak var commericalAds: UIStackView!
    @IBOutlet weak var housingStack: UIStackView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var cancelButton: UIButton!
    
    /// this UIButton has multiple function & name
    @IBOutlet var actionButton: UIButton!
    
    weak var delegate: GeneralPopUpActionDelegate?
    public var typeOfPopUp : PopUpTypes = .login
    public var parentVC = UIViewController()
    
    override func viewDidLoad(){
        super.viewDidLoad()
                parentVC.view.alpha = 0.5
        self.view.UIViewAction {[weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch typeOfPopUp {
        case .login:
            typeOfPopUp = .login
            actionButton.setTitle("تسجيل الدخول".localized, for: .normal)
            titleLabel.text = "من فضلك، قم بتسجيل الدخول اولاً"
        case .logout:
            typeOfPopUp = .logout
            actionButton.setTitle("تسجيل الخروج".localized, for: .normal)
            titleLabel.text = "هل تريد تسجيل الخروج ؟"
        case .deactivateAccount:
            typeOfPopUp = .deactivateAccount
            actionButton.setTitle("حذف الحساب".localized, for: .normal)
            titleLabel.text = "يرجى ملاحظة أنه إذا قمت بتأكيد هذا ، فسيتم حذف جميع البيانات المرتبطة بهذاالحساب نهائيًا"
        case .block:
            typeOfPopUp = .block
            actionButton.backgroundColor = #colorLiteral(red: 1, green: 0.2815943062, blue: 0.4013384879, alpha: 1)
            containerView.layer.borderWidth = 3
            containerView.layer.borderColor = #colorLiteral(red: 1, green: 0.2815943062, blue: 0.4013384879, alpha: 1)
            imageView.image = UIImage(named: "blockImage")
            actionButton.setTitle("حظر".localized, for: .normal)
            titleLabel.text =  "هل انت متأكد من انك تريد حظر هذاالمزود؟"

        case .commerical:
            commericalAds.isHidden = false
            titleLabel.isHidden = true
            imageView.image = UIImage(named: "commericalAdsImage")

        case .housing:
            housingStack.isHidden = false
            titleLabel.isHidden = true
            imageView.image = UIImage(named: "housingAdsImage")
        case .delete:
            typeOfPopUp = .delete 
            actionButton.setTitle("حذف".localized, for: .normal)
            titleLabel.text = "هل انت متأكد انك تريد حذف الاعلان"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
                parentVC.view.alpha = 1.0
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        delegate?.buttonActions(self, actionType: self.typeOfPopUp)
    }
}
