//
//  SongDetailHeaderViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 19.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit

final class SongDetailHeaderViewController: UIViewController {
    // MARK: - Properties

    private let app: SongDetailsModel
    private let imageDownloader = ImageDownloader()
    private var songDetailHeaderView: SongDetailHeaderView {
        return self.view as! SongDetailHeaderView
    }

    // MARK: - Init

    init(app: ITunesSong) {
        self.app = SongDetailsModelFactory.detailsModel(from: app)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        self.view = SongDetailHeaderView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillData()
    }

    // MARK: - Private

    private func fillData() {
        self.downloadImage()
        self.songDetailHeaderView.titleLabel.text = self.app.name
        self.songDetailHeaderView.subtitleLabel.text = self.app.artist
    }

    private func downloadImage() {
        guard let url = self.app.iconUrl else { return }
        self.imageDownloader.getImage(fromUrl: url) { [weak self] image, _ in
            self?.songDetailHeaderView.imageView.image = image
        }
    }
}
