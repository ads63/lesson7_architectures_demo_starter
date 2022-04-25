//
//  AppSearchViewInputProtocol.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 18.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
protocol AppSearchViewInputProtocol: class {
    var searchResults: [ITunesApp] { get set }
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}
