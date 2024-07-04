//
//  Helper.swift
//  CARDIZERR
//
//  Created by Osama Abu hdba on 20/05/2023.
//

import Foundation
import DropDown

class Helper {
    typealias CompletionHandler = (Index, String) -> Void
    static var appLanguage:String? {
        get{
            let firstLunch = UserDefaults.standard.string(forKey: "appLanguage")
            return firstLunch
        }set{
            UserDefaults.standard.set(newValue, forKey: "appLanguage")
            UserDefaults.standard.synchronize()
        }
    }

    class func setupDropDown(dropDownBtn: UIView , dropDown: DropDown , imagesArr: [UIImage]? = nil , stringsArr : [String] ,  completion: @escaping CompletionHandler) {
        self.customizeDropDown()
        dropDown.anchorView = dropDownBtn
        dropDown.bottomOffset = CGPoint(x: 0, y: dropDownBtn.bounds.height)
        dropDown.dataSource = stringsArr
        if imagesArr != nil {
            dropDown.cellNib = UINib(nibName: "dropDownTableCell", bundle: nil)
            dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
                cell.textLabel?.textAlignment = .right
//                cell.backgroundColor = .red
                print("Item\(item)")
            }
        }
        dropDown.selectionAction = { (index, item) in
            completion(index , item)
        }
    }

    class func customizeDropDown() {
        let appearance = DropDown.appearance()
        appearance.backgroundColor = .white
        appearance.selectionBackgroundColor = #colorLiteral(red: 0.3647058824, green: 0.1870486438, blue: 0.6015628576, alpha: 0.5)
        appearance.layer.cornerRadius = 20
        appearance.layer.masksToBounds = true
        appearance.layer.shadowColor = UIColor(white: 0.6, alpha: 1).cgColor
        appearance.layer.shadowOpacity = 0.9
        appearance.layer.shadowRadius = 10
        appearance.animationduration = 0.2
        appearance.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        //        appearance.textFont = UIFont.appFontRegular(ofSize: 13)
        if #available(iOS 11.0, *) {
            appearance.setupMaskedCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner])
        }
    }
}
