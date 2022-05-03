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
        let appsNavVC = configureApps()
        let songNavVC = configureSongs()
        let rootVC = UITabBarController()
        rootVC.viewControllers = [appsNavVC, songNavVC]
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }

    private func configureApps() -> UINavigationController {
        // MARK: - MVP configure

        let appsViewModel = SearchViewModel(searchService: ITunesSearchService(),
                                            downloadAppsService: FakeDownloadAppsService())
        let appsRootVC = SearchAppsViewController(viewModel: appsViewModel)
        appsViewModel.viewController = appsRootVC
        appsRootVC.navigationItem.title = "Search apps in iTunes"
        return configureNavigationController(rootViewController: appsRootVC,
                                             title: "Apps",
                                             image: nil,
                                             tag: 0)
    }

    private func configureSongs() -> UINavigationController {
        // MARK: - VIPER onfigure

        let router = SearchRouter()
        let interactor = SearchInteractor()
        let songsPresenter = SongsSearchPresenter(interactor: interactor
                                                  , router: router)
        let songRootVC = SearchSongsViewController(presenter: songsPresenter)
        songsPresenter.viewInput = songRootVC
        router.viewController = songRootVC
        songRootVC.navigationItem.title = "Search songs in iTunes"
        return configureNavigationController(rootViewController: songRootVC,
                                             title: "Songs",
                                             image: nil,
                                             tag: 1)
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
