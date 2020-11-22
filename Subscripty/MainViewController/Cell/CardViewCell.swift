//
//  CardViewCell.swift
//  Subscripty
//
//  Created by Михаил Борисов on 12.08.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit
import SwiftUI

class CollapsingCell: UICollectionViewCell {

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.6, delay: 0.1, usingSpringWithDamping: 2, initialSpringVelocity: 0.2, options: [.curveEaseInOut], animations: {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.9, y: 0.9) :  .identity
            }, completion: nil )
        }
    }
}

final class HostingCollectionViewCell<Content: View>: CollapsingCell {

    func host(_ view: Content, parent: UIViewController, environment: CardEntity) {

        let swiftUICellViewController = UIHostingController(rootView: view.environmentObject(CardEnvironment(card: environment.toCard())))
        swiftUICellViewController.view.backgroundColor = .clear
        layoutIfNeeded()
        parent.addChild(swiftUICellViewController)
        contentView.addSubview(swiftUICellViewController.view)
        swiftUICellViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            swiftUICellViewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            swiftUICellViewController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            swiftUICellViewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            swiftUICellViewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        swiftUICellViewController.didMove(toParent: parent)
        swiftUICellViewController.view.layoutIfNeeded()

    }
}
