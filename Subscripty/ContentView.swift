//
//  ContentView.swift
//  Subscripty
//
//  Created by Михаил Борисов on 11.08.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit
import SPStorkController

final class MainViewController: UIViewController {

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
            let controller = UIViewController()
            let transitionDelegate = SPStorkTransitioningDelegate()
            controller.transitioningDelegate = transitionDelegate
            controller.modalPresentationStyle = .custom
            controller.modalPresentationCapturesStatusBarAppearance = true
            self?.present(controller, animated: true, completion: nil)
        }
    }
}

