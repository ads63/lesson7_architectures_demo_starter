//
//  SongCell.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 19.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SongCell: UITableViewCell {
    // MARK: - Subviews
    
    private(set) lazy var logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = UIImage(named: "music")
        return logo
    }()
    
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
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - Methods
    
    func configure(with cellModel: SongCellModel) {
        self.titleLabel.text = cellModel.title
        self.subtitleLabel.text = cellModel.subtitle
    }
    
    // MARK: - UI
    
    override func prepareForReuse() {
        [self.titleLabel, self.subtitleLabel].forEach { $0.text = nil }
    }
    
    private func configureUI() {
        self.addLogoImage()
        self.addTitleLabel()
        self.addSubtitleLabel()
    }

    private func addLogoImage() {
        self.contentView.addSubview(self.logoImageView)
        NSLayoutConstraint.activate([
            self.logoImageView.topAnchor
                .constraint(equalTo: self.contentView.topAnchor, constant: 12.0),
            self.logoImageView.bottomAnchor
                .constraint(equalTo: self.contentView.bottomAnchor, constant: -24.0),
            self.logoImageView.widthAnchor
                .constraint(equalTo: self.logoImageView.heightAnchor),
            self.logoImageView.leftAnchor
                .constraint(equalTo: self.contentView.leftAnchor, constant: 5.0)
        ])
    }

    private func addTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor
                .constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.titleLabel.leftAnchor
                .constraint(equalTo: self.logoImageView.rightAnchor, constant: 5.0),
            self.titleLabel.rightAnchor
                .constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
        ])
    }
    
    private func addSubtitleLabel() {
        self.contentView.addSubview(self.subtitleLabel)
        NSLayoutConstraint.activate([
            self.subtitleLabel.topAnchor
                .constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4.0),
            self.subtitleLabel.leftAnchor
                .constraint(equalTo: self.logoImageView.rightAnchor, constant: 5.0),
            self.subtitleLabel.rightAnchor
                .constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
        ])
    }
}
