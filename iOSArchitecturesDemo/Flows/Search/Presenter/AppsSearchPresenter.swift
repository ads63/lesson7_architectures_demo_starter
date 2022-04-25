//
//  AppsSearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 18.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit
final class AppsSearchPresenter {
    // MARK: - view controller

    weak var viewInput: (UIViewController & AppSearchViewInputProtocol)?

    private let searchService = ITunesSearchService()

    private func requestApps(with query: String) {
        self.searchService.getApps(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            self.viewInput?.throbber(show: false)
            result
                .withValue { apps in
                    guard !apps.isEmpty else {
                        self.viewInput?.showNoResults()
                        return
                    }
                    self.viewInput?.hideNoResults()
                    self.viewInput?.searchResults = apps
                }
                .withError {
                    self.viewInput?.showError(error: $0)
                }
        }
    }

    private func openAppDetails(with app: ITunesApp) {
        let appDetaillViewController = AppDetailViewController(app: app)
        self.viewInput?.navigationController?
            .pushViewController(appDetaillViewController, animated: true)
    }
}

// MARK: - SearchViewOutput

extension AppsSearchPresenter: AppSearchViewOutputProtocol {
    func viewDidSearch(with query: String) {
        self.viewInput?.throbber(show: true)
        self.requestApps(with: query)
    }

    func viewDidSelect(_ app: ITunesApp) {
        self.openAppDetails(with: app)
    }
}
