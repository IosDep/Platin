//
//  UIView+EX.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 03/02/2023.
//

import UIKit

typealias HandlerView = (() -> Void)
internal var handlerActions: [UIView: HandlerView] = [:]

extension UIView {

    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable var shadowColor: UIColor?{
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
        get{
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
    }

    @IBInspectable var shadowOpacity: Float{
        set {
            layer.shadowOpacity = newValue
        }
        get{
            return layer.shadowOpacity
        }
    }

    @IBInspectable var shadowOffset: CGSize{
        set {
            layer.shadowOffset = newValue
        }
        get{
            return layer.shadowOffset
        }
    }

    @IBInspectable var shadowRadius: CGFloat{
        set {
            layer.shadowRadius = newValue
        }
        get{
            return layer.shadowRadius
        }
    }

    func dropShadowWithCornerRaduis() {
          layer.masksToBounds = true
          layer.cornerRadius = 16
          layer.shadowColor = UIColor.gray.cgColor
          layer.shadowOpacity = 0.5
          layer.shadowOffset = CGSize(width: 0, height: 0)
          layer.shadowRadius = 1
          layer.shouldRasterize = true
          layer.rasterizationScale = UIScreen.main.scale
      }

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
            layer.masksToBounds = false
            layer.shadowOffset = offset
            layer.shadowColor = color.cgColor
            layer.shadowRadius = radius
            layer.shadowOpacity = opacity

            let backgroundCGColor = backgroundColor?.cgColor
            backgroundColor = nil
            layer.backgroundColor =  backgroundCGColor
        }

    func addTapGesture(tapNumber: Int, target: Any, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
}

extension UIView {
    @discardableResult
    func addFitSubview(_ view: UIView,
                       leading: CGFloat = 0,
                       leadingPriority: UILayoutPriority = .required,
                       trailing: CGFloat = 0,
                       trailingPriority: UILayoutPriority = .required,
                       top: CGFloat = 0,
                       topPriority: UILayoutPriority = .required,
                       bottom: CGFloat = 0,
                       bottomPriority: UILayoutPriority = .required) -> (leading: NSLayoutConstraint, trailing: NSLayoutConstraint, top: NSLayoutConstraint, bottom: NSLayoutConstraint) {

        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        let leadingConstraint = view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading)
        leadingConstraint.priority = leadingPriority
        leadingConstraint.isActive = true

        let topConstraint = view.topAnchor.constraint(equalTo: topAnchor, constant: top)
        topConstraint.priority = topPriority
        topConstraint.isActive = true

        let trailingConstraint = self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing)
        trailingConstraint.priority = trailingPriority
        trailingConstraint.isActive = true

        let bottomConstraint = self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
        bottomConstraint.priority = bottomPriority
        bottomConstraint.isActive = true

        return (leading: leadingConstraint, trailing: trailingConstraint, top: topConstraint, bottom: bottomConstraint)
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    static var identifier: String {
        return String(describing: self)
    }

    static func isRTL() -> Bool {
        return appearance().semanticContentAttribute == .forceRightToLeft
    }
}

extension UIView {
    internal static func emptyHanlder() {
        handlerActions = [:]    }
    internal func emptyHanlder() {
        handlerActions = [:]
    }

    internal func UIViewAction(selector: @escaping HandlerView) {
        self.isUserInteractionEnabled = true
        actionHandleBlock(action: selector)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.triggerActionHandleBlock))
        self.addGestureRecognizer(tap)
    }

    internal func actionHandleBlock(action:(() -> Void)? = nil) {
        if action != nil {
            handlerActions[self] = action
        } else {
            guard let action = handlerActions[self] else { return }
            action()
        }
    }
    @objc func triggerActionHandleBlock() {
        self.actionHandleBlock()
    }
}
