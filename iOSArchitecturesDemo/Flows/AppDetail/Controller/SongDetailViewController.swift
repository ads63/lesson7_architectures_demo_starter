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

    lazy var headerViewController = SongDetailHeaderViewController(app: self.app!)
    lazy var songDetailsViewController = SongDescriptionViewController(app: self.app!)

    init(app: ITunesSong) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }

    private func configureUI() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.largeTitleDisplayMode = .never
        self.addHeaderViewController()
        self.addDescriptionViewController()
    }

    private func addHeaderViewController() {
        self.addChild(self.headerViewController)
        self.view.addSubview(self.headerViewController.view)
        self.headerViewController.didMove(toParent: self)
        self.headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerViewController.view.topAnchor.constraint(equalTo:
                self.view.topAnchor),
            self.headerViewController.view.leftAnchor.constraint(equalTo:
                self.view.leftAnchor),
            self.headerViewController.view.rightAnchor.constraint(equalTo:
                self.view.rightAnchor),
        ])
    }

    private func addDescriptionViewController() {
        self.addChild(self.songDetailsViewController)
        self.view.addSubview(self.songDetailsViewController.view)
        self.songDetailsViewController.didMove(toParent: self)
        self.songDetailsViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.songDetailsViewController.view.topAnchor.constraint(equalTo:
                self.headerViewController.view.bottomAnchor),
            self.songDetailsViewController.view.leftAnchor.constraint(equalTo:
                self.view.leftAnchor),
            self.songDetailsViewController.view.rightAnchor.constraint(equalTo:
                self.view.rightAnchor),
            self.songDetailsViewController.view.bottomAnchor.constraint(equalTo:
                self.view.bottomAnchor),
        ])
    }
}
