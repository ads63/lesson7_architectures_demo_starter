//
//  AppCell.swift
//  iOSArchitecturesDemo
//
//  Created by Evgeny Kireev on 01/03/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

final class AppCell: UITableViewCell {
    // MARK: - Subviews

    var onDownloadButtonTap: (() -> Void)?
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    private(set) lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    private(set) lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel()
        button.setTitle("Load", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 4
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        return button
    }()
    
    private(set) lazy var downloadProgressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()

    @IBAction func downloadButtonTapped(_ sender: UIButton) {
        self.onDownloadButtonTap?()
    }

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.downloadButton.addTarget(self, action: #selector(self.downloadButtonTapped(_:)), for: .touchUpInside)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - Methods
    
    func configure(with cellModel: AppCellModel) {
        self.titleLabel.text = cellModel.title
        self.subtitleLabel.text = cellModel.subtitle
        self.ratingLabel.text = cellModel.rating
        switch cellModel.downloadState {
        case .notStarted:
            self.downloadProgressLabel.text = nil
        case .inProgress(let progress):
            let progressToShow = round(progress * 100.0) / 100.0
            self.downloadProgressLabel.text = "\(progressToShow)"
        case .downloaded:
            self.downloadProgressLabel.text = "Загружено"
        }
    }
    
    // MARK: - UI
    
    override func prepareForReuse() {
        [self.titleLabel, self.subtitleLabel, self.ratingLabel].forEach { $0.text = nil }
    }
    
    private func configureUI() {
        self.addTitleLabel()
        self.addSubtitleLabel()
        self.addRatingLabel()
        self.addDownloadButton()
        self.addDownloadProgressLabel()
    }

    private func addDownloadButton() {
        self.contentView.addSubview(self.downloadButton)
        NSLayoutConstraint.activate([
            self.downloadButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.downloadButton.leftAnchor.constraint(equalTo: self.titleLabel.rightAnchor, constant: 0.0),
            self.downloadButton.heightAnchor.constraint(equalToConstant: 16.0),
            self.downloadButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -4.0)
        ])
    }

    private func addDownloadProgressLabel() {
        self.contentView.addSubview(self.downloadProgressLabel)
        NSLayoutConstraint.activate([
            self.downloadProgressLabel.topAnchor.constraint(equalTo: self.ratingLabel.topAnchor),
            self.downloadProgressLabel.leftAnchor.constraint(equalTo: self.ratingLabel.rightAnchor),
            self.downloadProgressLabel.heightAnchor.constraint(equalTo: self.ratingLabel.heightAnchor),
            self.downloadProgressLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -4.0)
        ])
    }

    private func addTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0),
            self.titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -60.0)
        ])
    }
    
    private func addSubtitleLabel() {
        self.contentView.addSubview(self.subtitleLabel)
        NSLayoutConstraint.activate([
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4.0),
            self.subtitleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0),
            self.subtitleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
        ])
    }
    
    private func addRatingLabel() {
        self.contentView.addSubview(self.ratingLabel)
        NSLayoutConstraint.activate([
            self.ratingLabel.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 4.0),
            self.ratingLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0),
            self.ratingLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -100.0)
        ])
    }
}
