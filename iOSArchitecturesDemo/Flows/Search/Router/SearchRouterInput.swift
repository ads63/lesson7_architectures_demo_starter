//
//  SearchRouterInput.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 25.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
protocol SearchRouterInput {
    func openDetails(for entity: ITunesSong)
    func openSongInITunes(_ entity: ITunesSong)
    }
