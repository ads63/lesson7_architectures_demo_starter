//
//  SongDetailsHeaderView.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 19.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SongDetailHeaderView: UIView {
    var onPlayButtonTap: (() -> Void)?

    // MARK: - Subviews

    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30.0
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 2
        return label
    }()

    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()

    private(set) lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Play", for: .normal)
        button.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        button.layer.cornerRadius = 16.0
        return button
    }()

    private(set) lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.text = "0"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()

    private(set) lazy var progressBar: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        progress.progressViewStyle = .default
        progress.progressTintColor = .blue
        return progress
    }()

    private(set) lazy var leftPlayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.text = "00:00"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()

    private(set) lazy var rightPlayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.text = "00:00"
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.playButton.addTarget(self, action: #selector(self.playButtonTapped(_:)), for: .touchUpInside)
        self.setupLayout()
    }

    @IBAction func playButtonTapped(_ sender: UIButton) {
        self.onPlayButtonTap?()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupLayout()
    }

    // MARK: - UI

    private func setupLayout() {
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subtitleLabel)
        self.addSubview(self.playButton)
        self.addSubview(self.progressBar)
        self.addSubview(self.leftPlayLabel)
        self.addSubview(self.rightPlayLabel)
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo:
                self.safeAreaLayoutGuide.topAnchor, constant: 12.0),
            self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor,
                                                 constant: 16.0),
            self.imageView.widthAnchor.constraint(equalToConstant: 120.0),
            self.imageView.heightAnchor.constraint(equalToConstant: 120.0),
            self.titleLabel.topAnchor
                .constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                            constant: 12.0),
            self.titleLabel.leftAnchor
                .constraint(equalTo: self.imageView.rightAnchor,
                            constant: 16.0),
            self.titleLabel.rightAnchor
                .constraint(equalTo: self.rightAnchor,
                            constant: -16.0),
            self.subtitleLabel.topAnchor
                .constraint(equalTo: self.titleLabel.bottomAnchor,
                            constant: 12.0),
            self.subtitleLabel.leftAnchor
                .constraint(equalTo: self.titleLabel.leftAnchor),
            self.subtitleLabel.rightAnchor
                .constraint(equalTo: self.titleLabel.rightAnchor),
            self.playButton.leftAnchor
                .constraint(equalTo: self.imageView.rightAnchor,
                            constant: 16.0),
            self.playButton.bottomAnchor
                .constraint(equalTo: self.imageView.bottomAnchor),
            self.playButton.widthAnchor.constraint(equalToConstant: 80.0),
            self.playButton.heightAnchor.constraint(equalToConstant: 32.0),
            self.progressBar.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 16.0),
            self.progressBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 64.0),
            self.progressBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -64.0),
            self.progressBar.heightAnchor.constraint(equalToConstant: 16.0),
            self.leftPlayLabel.topAnchor.constraint(equalTo: self.progressBar.topAnchor),
            self.leftPlayLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8.0),
            self.leftPlayLabel.heightAnchor.constraint(equalToConstant: 24.0),
            self.leftPlayLabel.rightAnchor.constraint(equalTo: self.progressBar.leftAnchor),
            self.rightPlayLabel.topAnchor.constraint(equalTo: self.progressBar.topAnchor),
            self.rightPlayLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8.0),
            self.rightPlayLabel.heightAnchor.constraint(equalToConstant: 24.0),
            self.rightPlayLabel.leftAnchor.constraint(equalTo: self.progressBar.rightAnchor),
            self.bottomAnchor
                .constraint(equalTo: self.rightPlayLabel.bottomAnchor, constant: 16.0),
        ])
    }
}
