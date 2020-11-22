//
//  RootMainViewController.swift
//  Subscripty
//
//  Created by Михаил Борисов on 13.08.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit

final class RootMainViewController: UINavigationController {

    private var currentView: UIViewController

    init(view: UIViewController) {
        self.currentView = view
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let mainViewController = currentView
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .heavy)]
        viewControllers = [mainViewController]

    }

}
