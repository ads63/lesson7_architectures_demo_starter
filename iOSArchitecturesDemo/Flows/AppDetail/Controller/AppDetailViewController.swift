//
//  AppDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppDetailViewController: UIViewController {
    public var app: ITunesApp?

    lazy var headerViewController = AppDetailHeaderViewController(app: self.app!)
    lazy var appDescriptionViewController = AppDescriptionViewController(app: self.app!)

    init(app: ITunesApp) {
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
        self.addChild(self.appDescriptionViewController)
        self.view.addSubview(self.appDescriptionViewController.view)
        self.appDescriptionViewController.didMove(toParent: self)
        self.appDescriptionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.appDescriptionViewController.view.topAnchor.constraint(equalTo:
                self.headerViewController.view.bottomAnchor),
            self.appDescriptionViewController.view.leftAnchor.constraint(equalTo:
                self.view.leftAnchor),
            self.appDescriptionViewController.view.rightAnchor.constraint(equalTo:
                self.view.rightAnchor),
            self.appDescriptionViewController.view.bottomAnchor.constraint(equalTo:
                self.view.bottomAnchor),
        ])
    }
}
