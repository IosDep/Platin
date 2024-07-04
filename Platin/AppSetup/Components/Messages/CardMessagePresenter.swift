//
//  CardMessagePresenter.swift
//  express-stores
//
//  Created by Hussein AlRyalat on 02/11/2021.
//

import UIKit
import SwiftEntryKit

class CardMessagePresenter: ScreenMessagePresenterType {

    func show(message: String, messageType: PresentedMessageType) {
        // construct an alert controller based on the given configuration

        var alertAttributes = EKAttributes()
        alertAttributes.position = .top
        alertAttributes.windowLevel = .statusBar
        alertAttributes.screenBackground = .clear
        alertAttributes.roundCorners = .all(radius: 6)
        alertAttributes.shadow = .active(with: .init(color: .init(UIColor.lightGray),
                                                     opacity: 0.2,
                                                     radius: 4,
                                                     offset: .zero))

        alertAttributes.screenInteraction = .forward
        alertAttributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        alertAttributes.displayDuration = 3
        alertAttributes.entryInteraction = .dismiss
        alertAttributes.name = String(describing: self)
        alertAttributes.hapticFeedbackType = messageType == .success ? .success : .error
        alertAttributes.entranceAnimation = .init(translate: .init(duration: 0.25), scale: nil, fade: nil)
        alertAttributes.exitAnimation = .init(translate: .init(duration: 0.25), scale: nil, fade: nil)

        let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 0.8)
        let heightConstraint = EKAttributes.PositionConstraints.Edge.intrinsic

        alertAttributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)

        let contentView = ContentView(title: message, messageType: messageType)

        SwiftEntryKit.display(entry: contentView, using: alertAttributes)
    }
}

extension CardMessagePresenter {
    class ContentView: UIView {

        let titleLabel = UILabel()

        let title: String
        let messageType: PresentedMessageType

        init(title: String, messageType: PresentedMessageType) {
            self.title = title
            self.messageType = messageType
            super.init(frame: .zero)
            setup()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setup() {
            backgroundColor = messageType.color
            layer.cornerRadius = 20

            self.addSubview(titleLabel)

//            titleLabel.font = .font(for: .medium, size: 14)
            titleLabel.textColor = .white
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .center
            titleLabel.text = title

            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.topAnchor.constraint(equalTo: titleLabel.superview!.topAnchor, constant: 10).isActive = true
            titleLabel.bottomAnchor.constraint(equalTo: titleLabel.superview!.bottomAnchor, constant: -10).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo: titleLabel.superview!.leadingAnchor, constant: 15).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: titleLabel.superview!.trailingAnchor, constant: -15).isActive = true

        }
    }
}
