//
//  SearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 25.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SearchRouter: SearchRouterInput {
    weak var viewController: UIViewController?
    func openDetails(for entity: ITunesSong) {
        let detaillViewController = SongDetailViewController(app: entity)
        self.viewController?.navigationController?
            .pushViewController(detaillViewController, animated: true)
    }

    func openSongInITunes(_ entity: ITunesSong) {
        guard let urlString = entity.viewUrl,
              let url = URL(string: urlString)
        else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
