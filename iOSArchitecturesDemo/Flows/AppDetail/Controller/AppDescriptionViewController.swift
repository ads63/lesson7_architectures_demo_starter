//
//  AppDescriptionViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 16.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class AppDescriptionViewController: UIViewController {
    // MARK: - Properties

    private let app: AppDetailsModel
    private var detailsView: AppDescriptionView {
        return self.view as! AppDescriptionView
    }

    // MARK: - Init

    init(app: ITunesApp) {
        self.app = AppDetailsModelFactory.appDetailsModel(from: app)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        self.view = AppDescriptionView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillData()
    }

    // MARK: - Private

    private func fillData() {
        self.detailsView.appVersionLabel.text = self.app.version
        self.detailsView.appVersionDateLabel.text = self.app.date
        self.detailsView.appDescriptionTextView.text = self.app.description
    }
}
