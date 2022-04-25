//
//  AppDetailHeaderViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 15.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class AppDetailHeaderViewController: UIViewController {
    // MARK: - Properties

    private let app: AppDetailsModel
    private let imageDownloader = ImageDownloader()
    private var appDetailHeaderView: AppDetailHeaderView { return self.view as! AppDetailHeaderView
    }

    // MARK: - Init

    init(app: ITunesApp) {
        self.app = AppDetailsModelFactory.appDetailsModel(from: app)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        self.view = AppDetailHeaderView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillData()
    }

    // MARK: - Private

    private func fillData() {
        self.downloadImage()
        self.appDetailHeaderView.titleLabel.text = self.app.name
        self.appDetailHeaderView.subtitleLabel.text = self.app.company
        self.appDetailHeaderView.ratingLabel.text = self.app.rating
    }

    private func downloadImage() {
        guard let url = self.app.iconUrl else { return }
        self.imageDownloader.getImage(fromUrl: url) { [weak self] image, _ in
            self?.appDetailHeaderView.imageView.image = image
        }
    }
}
