//
//  SongDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 19.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SongDetailViewController: UIViewController {
    public var app: ITunesSong?
    var headerViewModel: SongHeaderViewModel?
    var headerViewController: SongDetailHeaderViewController?
    lazy var songDetailsViewController = SongDescriptionViewController(app: self.app!)

    init(app: ITunesSong) {
        super.init(nibName: nil, bundle: nil)
        self.app = app
        self.headerViewModel =
            SongHeaderViewModel(playService: FakePlaySongService())
        self.headerViewController =
            SongDetailHeaderViewController(viewModel: self.headerViewModel)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.headerViewModel?.song = self.app
    }

    private func configureUI() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.largeTitleDisplayMode = .never
        self.addHeaderViewController()
        self.addDescriptionViewController()
    }

    private func addHeaderViewController() {
        guard let headerViewController = headerViewController else {
            return
        }
        self.addChild(headerViewController)
        self.view.addSubview(headerViewController.view)
        self.headerViewController?.didMove(toParent: self)
        self.headerViewController?.view
            .translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerViewController.view.topAnchor.constraint(equalTo:
                self.view.topAnchor),
            headerViewController.view.leftAnchor.constraint(equalTo:
                self.view.leftAnchor),
            headerViewController.view.rightAnchor.constraint(equalTo:
                self.view.rightAnchor),
        ])
    }

    private func addDescriptionViewController() {
        guard let headerViewController = headerViewController else {
            return
        }
        self.addChild(self.songDetailsViewController)
        self.view.addSubview(self.songDetailsViewController.view)
        self.songDetailsViewController.didMove(toParent: self)
        self.songDetailsViewController.view
            .translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.songDetailsViewController.view.topAnchor.constraint(equalTo:
                headerViewController.view.bottomAnchor),
            self.songDetailsViewController.view.leftAnchor.constraint(equalTo:
                self.view.leftAnchor),
            self.songDetailsViewController.view.rightAnchor.constraint(equalTo:
                self.view.rightAnchor),
            self.songDetailsViewController.view.bottomAnchor.constraint(equalTo:
                self.view.bottomAnchor),
        ])
    }
}
