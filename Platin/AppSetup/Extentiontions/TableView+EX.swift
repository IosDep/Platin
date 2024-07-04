//
//  TableView+EX.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 03/02/2023.
//

import UIKit

protocol Identifiable: AnyObject {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String { return String(describing: self) }
}

extension NSObject: Identifiable { }

protocol ReusableCell: Identifiable { }

protocol ReusableView: Identifiable { }

extension UICollectionViewCell: ReusableCell { }

extension UITableViewCell: ReusableCell {}

extension UICollectionReusableView: ReusableView { }

extension UITableView {

    func register<T:UITableViewCell>(_: T.Type){
        let bundle = Bundle(for: T.self)
        let nib =  UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.nibName)
    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath)-> T{

        guard let cell = dequeueReusableCell(withIdentifier: T.nibName, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.nibName)")
        }
        return cell
    }



}

extension UICollectionView {
    func dequeReusableView<T: ReusableView>(reusableViewType: T.Type,
                                            kind: String,
                                            for indexPath: IndexPath) -> T {
        guard let supplementary = dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: reusableViewType.identifier,
                                                                   for: indexPath) as? T else {
            fatalError()
        }

        return supplementary
    }
}

extension UITableViewCell: NibLoadableView{
    static var nibName:String {
        return String(describing: self)
    }
}

extension NSObject {
    class var className: String {
        return "\(self)"
    }
}
