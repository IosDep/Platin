//
//  NIB+Extension.swift
//  CARDIZERR
//
//  Created by Osama Abu hdba on 28/03/2023.
//

import Foundation
import UIKit
protocol CustomViewNibLoadable: NibLoadable {
    
    var containerView: UIView! { get set }
    func loadView()
}

extension CustomViewNibLoadable where Self: UIView {
    func loadView() {
        Self.instantiate(WithFileOwner: self)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addFitSubview(containerView)
        self.backgroundColor = .clear
    }
}

protocol NibLoadable: AnyObject {
    static var nibName: String { get }
}

protocol Reuseable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension NibLoadable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
    
    static func instantiateFromNib() -> Self {
        guard let nib = Bundle.main.loadNibNamed(Self.nibName, owner: nil, options: nil) else {
            fatalError("Could not load Nib named: \(Self.nibName)")
        }
        guard let view = nib.first as? Self else {
            fatalError("Could not load View from Nib named: \(Self.nibName)")
        }
        return view
    }
    
    static func instantiate(WithFileOwner owner: Any) {
        let bundle = Bundle(for: Self.self)
        bundle.loadNibNamed(Self.nibName, owner: owner, options: nil)
    }
}

extension Reuseable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
