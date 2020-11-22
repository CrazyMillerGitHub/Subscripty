//
//  ProfileViewPresenter.swift
//  Subscripty
//
//  Created by Михаил Борисов on 15.08.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit
import IntentsUI

final class ProfileViewPresenter: NSObject {

    private weak var delegate: UIViewController?
    private var siriButton: INUIAddVoiceShortcutButton

    private var intent: WorkingIntent {
        let intent = WorkingIntent()
        intent.suggestedInvocationPhrase = "Добавь подписку"
        return intent
    }

    init(delegate: UIViewController, siriButton: INUIAddVoiceShortcutButton) {
        self.delegate = delegate
        self.siriButton = siriButton
        super.init()
        setupButton()
    }

    private func setupButton() {
        siriButton.translatesAutoresizingMaskIntoConstraints = false
        delegate?.view.addSubview(siriButton)
        guard let shortcut = INShortcut(intent: intent) else { return }

        siriButton.shortcut = shortcut
        siriButton.delegate = self
    }
}

extension ProfileViewPresenter: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewPresenter: INUIAddVoiceShortcutButtonDelegate {
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        addVoiceShortcutViewController.modalPresentationStyle = .formSheet
        delegate?.present(addVoiceShortcutViewController, animated: true, completion: nil)
    }

    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        editVoiceShortcutViewController.modalPresentationStyle = .formSheet
        delegate?.present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
}

extension ProfileViewPresenter: INUIEditVoiceShortcutViewControllerDelegate {
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }

    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

}
