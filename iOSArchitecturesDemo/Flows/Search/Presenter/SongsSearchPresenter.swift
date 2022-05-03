//
//  SongsSearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 18.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Alamofire
import UIKit

final class SongsSearchPresenter {
    let interactor: SearchInteractorInput
    let router: SearchRouterInput

    // MARK: - view controller

    weak var viewInput: (UIViewController & SongSearchViewInputProtocol)?

    private let searchService = ITunesSearchService()

    init(interactor: SearchInteractorInput, router: SearchRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - SearchViewOutput

extension SongsSearchPresenter: SongSearchViewOutputProtocol {
    func viewDidSearch(with query: String) {
        self.viewInput?.throbber(show: true)
        self.interactor.requestSongs(with: query) { [weak self] result in
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

    func viewDidSelect(_ app: ITunesSong) {
        self.router.openDetails(for: app)
    }
}
