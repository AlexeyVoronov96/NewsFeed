//
//  SceneDelegate.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let feedViewController = FeedViewController()
        let navigationController = UINavigationController(rootViewController: feedViewController)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataManager.shared.saveContext()
    }
}
