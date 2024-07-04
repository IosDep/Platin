//
//  UIButton+EX.swift
//  CaravanRealEstate
//
//  Created by Osama Abu hdba on 17/11/2023.
//
import UIKit
import CoreImage

@IBDesignable
public extension UIButton {

    enum ImageDirection: Int {
        case fixed = 0
        case leftToRight = 1
        case rightToLeft = 2
        case mirror = 3 // Add the mirror case
    }

    @IBInspectable var imageDirection: Int {
        set {
            if let direction = ImageDirection(rawValue: newValue) {
                applyImageDirection(direction)
            }
        }
        get {
            return 0 // Default value
        }
    }

    private func applyImageDirection(_ direction: ImageDirection) {
        switch direction {
        case .leftToRight:
            // Apply left-to-right image direction
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        case .rightToLeft:
            // Apply right-to-left image direction
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
        case .mirror:
            // Apply mirror effect
            applyMirrorEffect()
        default:
            break
        }
    }

    private func applyMirrorEffect() {
        // Create a CALayer for the mirror effect
        let mirrorLayer = CALayer()
        mirrorLayer.contents = self.layer.contents
        mirrorLayer.frame = self.layer.bounds
        mirrorLayer.opacity = 0.5

        // Apply a vertical scale transformation to the mirror layer
        mirrorLayer.transform = CATransform3DMakeScale(1, -1, 1)

        // Create a container layer to hold the original button layer and the mirror layer
        let containerLayer = CALayer()
        containerLayer.addSublayer(self.layer)
        containerLayer.addSublayer(mirrorLayer)

        // Apply the container layer to the button's layer
        self.layer.addSublayer(containerLayer)
    }
}
