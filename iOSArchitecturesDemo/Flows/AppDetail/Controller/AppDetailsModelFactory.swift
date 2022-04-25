//
//  AppDetailsModelFactory.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 15.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation

struct AppDetailsModel {
    let name: String
    let company: String
    let version: String
    let date: String
    let description: String
    let rating: String
    let iconUrl: String?
}

final class AppDetailsModelFactory {
    private static let inputDateFormatter = ISO8601DateFormatter()
    private static let outputDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()

    static func appDetailsModel(from model: ITunesApp) -> AppDetailsModel {
        return AppDetailsModel(name: model.appName,
                               company: model.company ?? "",
                               version: getPrettyVersion(version: model.version),
                               date: getPrettyDate(date: model.releaseDate),
                               description: model.appDescription ?? "",
                               rating: model.averageRating.flatMap { "\($0)" } ?? "",
                               iconUrl: model.iconUrl)
    }

    private static func getPrettyVersion(version: String?) -> String {
        guard let version = version else {
            return ""
        }
        return "version \(version)"
    }

    private static func getPrettyDate(date: String?) -> String {
        guard let date = date,
              let dateValue = inputDateFormatter.date(from: date) else { return "" }
        return outputDateFormatter.string(from: dateValue)
    }
}
