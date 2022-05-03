//
//  SongPlayingModel.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 28.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
struct SongPlayingModel {
    let trackName: String
    let artistName: String?
    let collectionName: String?
    let artwork: String?
    let country: String?
    let durationMills: Int?
    let playState: PlayingSong.PlayState
}
