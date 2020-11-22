//
//  SceneDelegate.swift
//  Subscripty
//
//  Created by Михаил Борисов on 11.08.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let contentView = RootMainViewController(view: MainViewController())

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = contentView
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}
