//
//  SearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 25.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Alamofire
import Foundation

final class SearchInteractor: SearchInteractorInput {
    private let searchService = ITunesSearchService()
    func requestSongs(with query: String, completion: @escaping
        (Result<[ITunesSong]>) -> Void)
    {
        self.searchService.getSongs(forQuery: query, completion: completion)
    }
}
