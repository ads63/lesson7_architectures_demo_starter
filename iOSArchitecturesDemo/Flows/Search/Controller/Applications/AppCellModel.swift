//
//  AppCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Evgeny Kireev on 02/06/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import Foundation

struct AppCellModel {
    let title: String
    let subtitle: String?
    let rating: String?
    let downloadState: DownloadingApp.DownloadState
}

enum AppCellModelFactory {
    static func cellModel(from model: SearchAppCellModel) -> AppCellModel {
        return AppCellModel(title: model.appName,
                            subtitle: model.company,
                            rating: model.averageRating >>- { "\($0)" },
                            downloadState: model.downloadState)
    }
}
