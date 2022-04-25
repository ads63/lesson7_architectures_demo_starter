//
//  SongDescriptionView.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 19.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit

final class SongDescriptionView: UIView {
    private static let topMargin = 5.0
    private static let leftMargin = 10.0
    private static let rightMargin = -10.0
    private static let bottomMargin = -10.0
    private static let interlineSpace = 5.0
    private static let lineHeight = 24.0

    // MARK: - Subviews
    
    let collectionLabel = UILabel()
    let countryLabel = UILabel()
    let durationLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - UI
    
    private func configureUI() {
        self.addSubViews()
        self.setupConstraints()
    }
    
    private func addSubViews() {
        self.collectionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.countryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.durationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.collectionLabel.backgroundColor = UIColor.white
        self.countryLabel.backgroundColor = UIColor.white
        self.durationLabel.backgroundColor = UIColor.white
        
        self.collectionLabel.textColor = UIColor.black
        self.countryLabel.textColor = UIColor.black
        self.durationLabel.textColor = UIColor.black
        
        self.collectionLabel.textAlignment = .left
        self.countryLabel.textAlignment = .left
        self.durationLabel.textAlignment = .left
        
        self.collectionLabel.adjustsFontSizeToFitWidth = true
        self.countryLabel.adjustsFontSizeToFitWidth = true
        self.durationLabel.adjustsFontSizeToFitWidth = true
        
        self.addSubview(self.collectionLabel)
        self.addSubview(self.countryLabel)
        self.addSubview(self.durationLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.collectionLabel.topAnchor
                .constraint(equalTo: self.topAnchor,
                            constant: SongDescriptionView.topMargin),
            self.collectionLabel.trailingAnchor
                .constraint(equalTo: self.trailingAnchor,
                            constant: SongDescriptionView.rightMargin),
            self.collectionLabel.leadingAnchor
                .constraint(equalTo: self.leadingAnchor,
                            constant: SongDescriptionView.leftMargin),
            self.countryLabel.topAnchor
                .constraint(equalTo: self.collectionLabel.bottomAnchor, constant: SongDescriptionView.interlineSpace),
            self.countryLabel.leadingAnchor
                .constraint(equalTo: self.leadingAnchor,
                            constant: SongDescriptionView.leftMargin),
            self.countryLabel.heightAnchor
                .constraint(equalToConstant: SongDescriptionView.lineHeight),
            self.countryLabel.widthAnchor
                .constraint(equalTo: self.widthAnchor,
                            multiplier: 0.5),
            self.durationLabel.topAnchor
                .constraint(equalTo: self.countryLabel.topAnchor),
            self.durationLabel.leadingAnchor
                .constraint(equalTo: self.countryLabel.trailingAnchor),
            self.durationLabel.heightAnchor
                .constraint(equalToConstant: SongDescriptionView.lineHeight),
            self.durationLabel.trailingAnchor
                .constraint(equalTo: self.trailingAnchor,
                            constant: SongDescriptionView.rightMargin)

        ])
    }
}
