//
//  SongDescriptionViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 19.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SongDescriptionViewController: UIViewController {
    // MARK: - Properties

    private let app: SongDetailsModel
    private var detailsView: SongDescriptionView {
        return self.view as! SongDescriptionView
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
        self.view = SongDescriptionView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillData()
    }

    // MARK: - Private

    private func fillData() {
        self.detailsView.collectionLabel.text = self.app.collection
        self.detailsView.countryLabel.text = self.app.country
        self.detailsView.durationLabel.text = self.app.durationSec
    }
}
