//
//  AppSearchViewOutputProtocol.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 18.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
protocol AppSearchViewOutputProtocol: class {
    func viewDidSearch(with query: String)
    func viewDidSelect(_ app: ITunesApp)
}
