//
//  SearchAppCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 26.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
struct SearchAppCellModel {
    let appName: String
    let company: String?
    let averageRating: Float?
    let downloadState: DownloadingApp.DownloadState
}
