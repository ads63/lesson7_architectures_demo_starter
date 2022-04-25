//
//  SongSearchViewOutputProtocol.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 19.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//


protocol SongSearchViewOutputProtocol: class {
    func viewDidSearch(with query: String)
    func viewDidSelect(_ app: ITunesSong)
}
