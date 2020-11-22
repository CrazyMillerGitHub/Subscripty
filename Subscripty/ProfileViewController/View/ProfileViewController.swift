//
//  ProfileViewController.swift
//  Subscripty
//
//  Created by Михаил Борисов on 14.08.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit
import IntentsUI

protocol ProfileViewCallable where Self: UIViewController {

    var siriButton: INUIAddVoiceShortcutButton { get }
}

final class ProfileViewController: UIViewController, ProfileViewCallable {

    private(set) var siriButton: INUIAddVoiceShortcutButton = INUIAddVoiceShortcutButton(style: .automatic)
    private var presenter: ProfileViewPresenter!

    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProfileViewPresenter(delegate: self, siriButton: siriButton)
        configureConstraints()
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            siriButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            siriButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)
        ])
    }

}
