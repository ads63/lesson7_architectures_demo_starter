//
//  ITunesSearchResult.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 19.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import Foundation

struct ITunesSearchResult<Element: Decodable>: Decodable {
    let resultCount: Int
    let results: [Element]
}
