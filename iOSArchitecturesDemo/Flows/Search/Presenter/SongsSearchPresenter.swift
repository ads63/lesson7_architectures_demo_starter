//
//  SongsSearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 18.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit
final class SongsSearchPresenter {
    // MARK: - view controller

    weak var viewInput: (UIViewController & SongSearchViewInputProtocol)?

    private let searchService = ITunesSearchService()

    private func requestApps(with query: String) {
        self.searchService.getSongs(forQuery: query) { [weak self] result in
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

    private func openAppDetails(with app: ITunesSong) {
        let detaillViewController = SongDetailViewController(app: app)
        self.viewInput?.navigationController?
            .pushViewController(detaillViewController, animated: true)
    }
}

// MARK: - SearchViewOutput

extension SongsSearchPresenter: SongSearchViewOutputProtocol {
    func viewDidSearch(with query: String) {
        self.viewInput?.throbber(show: true)
        self.requestApps(with: query)
    }

    func viewDidSelect(_ app: ITunesSong) {
        self.openAppDetails(with: app)
    }
}
