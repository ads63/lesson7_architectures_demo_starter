//
//  AppStartManager.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 19.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppStartManager {
    var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        let appsPresenter = AppsSearchPresenter()
        let songsPresenter = SongsSearchPresenter()
        let appsRootVC = SearchAppsViewController(presenter: appsPresenter)
        appsPresenter.viewInput = appsRootVC
        let songRootVC = SearchSongsViewController(presenter: songsPresenter)
        songsPresenter.viewInput = songRootVC
        appsRootVC.navigationItem.title = "Search apps in iTunes"
        songRootVC.navigationItem.title = "Search songs in iTunes"
        let appsNavVC = configureNavigationController(rootViewController: appsRootVC,
                                                      title: "Apps",
                                                      image: nil,
                                                      tag: 0)
        let songNavVC = configureNavigationController(rootViewController: songRootVC,
                                                      title: "Songs",
                                                      image: nil,
                                                      tag: 1)
        let rootVC = UITabBarController()
        rootVC.viewControllers = [appsNavVC, songNavVC]
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }

    private func configureNavigationController(rootViewController: UIViewController,
                                               title: String?,
                                               image: UIImage?,
                                               tag: Int) -> UINavigationController
    {
        let navVC = UINavigationController(rootViewController: rootViewController)
        navVC.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        navVC.navigationBar.barTintColor = UIColor.varna
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navVC
    }
}
