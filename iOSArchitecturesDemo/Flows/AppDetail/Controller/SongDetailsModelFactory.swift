//
//  SongDetailsModelFactory.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 19.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation

struct SongDetailsModel {
    let name: String
    let artist: String
    let collection: String
    let country: String
    let iconUrl: String?
    let durationSec: String
}

final class SongDetailsModelFactory {
    static func detailsModel(from model: ITunesSong) -> SongDetailsModel {
        return SongDetailsModel(name: model.trackName,
                                artist: model.artistName ?? "",
                                collection: model.collectionName ?? "",
                                country: getPrettyCountry(code: model.country),
                                iconUrl: model.artwork,
                                durationSec: getPrettyDuration(mills: model.durationMills))
    }

    private static func getPrettyDuration(mills: Int?) -> String {
        guard let mills = mills else { return "unknown" }
        let seconds = (mills + 500) / 1000
        return seconds != 1 ? "\(seconds) seconds" : "1 second"
    }

    private static func getPrettyCountry(code: String?) -> String {
        guard let code = code else { return "unknown" }
        return code
    }
}
