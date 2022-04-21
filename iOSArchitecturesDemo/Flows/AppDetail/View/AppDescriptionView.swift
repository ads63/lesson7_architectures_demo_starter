//
//  AppDescriptionView.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 14.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class AppDescriptionView: UIView {
    private static let topMargin = 5.0
    private static let leftMargin = 10.0
    private static let rightMargin = -10.0
    private static let bottomMargin = -10.0
    private static let interlineSpace = 5.0
    private static let lineHeight = 24.0

    // MARK: - Subviews
    
    let appVersionLabel = UILabel()
    let appVersionDateLabel = UILabel()
    let appDescriptionTextView = UITextView()
    
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
        self.backgroundColor = .white
        self.addSubViews()
        self.setupConstraints()
    }
    
    private func addSubViews() {
        self.appVersionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.appVersionDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.appDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        self.appVersionLabel.backgroundColor = UIColor.white
        self.appVersionDateLabel.backgroundColor = UIColor.white
        self.appDescriptionTextView.backgroundColor = UIColor.white
        
        self.appVersionLabel.textColor = UIColor.black
        self.appVersionDateLabel.textColor = UIColor.black
        self.appDescriptionTextView.textColor = UIColor.black
        
        self.appVersionLabel.textAlignment = .center
        self.appVersionDateLabel.textAlignment = .center
        
        self.appDescriptionTextView.isEditable = false
        self.appDescriptionTextView.isScrollEnabled = true
        
        self.appVersionLabel.adjustsFontSizeToFitWidth = true
        self.appVersionDateLabel.adjustsFontSizeToFitWidth = true
        
        self.addSubview(self.appVersionLabel)
        self.addSubview(self.appVersionDateLabel)
        self.addSubview(self.appDescriptionTextView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.appVersionLabel.topAnchor
                .constraint(equalTo: self.topAnchor,
                            constant: AppDescriptionView.topMargin),
            self.appVersionLabel.widthAnchor
                .constraint(equalTo: self.widthAnchor,
                            multiplier: 0.5),
            self.appVersionLabel.heightAnchor
                .constraint(equalToConstant: AppDescriptionView.lineHeight),
            self.appVersionLabel.leadingAnchor
                .constraint(equalTo: self.leadingAnchor,
                            constant: AppDescriptionView.leftMargin),
            self.appVersionDateLabel.topAnchor
                .constraint(equalTo: self.appVersionLabel.topAnchor),
            self.appVersionDateLabel.leadingAnchor
                .constraint(equalTo: self.appVersionLabel.trailingAnchor),
            self.appVersionDateLabel.heightAnchor
                .constraint(equalToConstant: AppDescriptionView.lineHeight),
            self.appVersionDateLabel.trailingAnchor
                .constraint(equalTo: self.trailingAnchor,
                            constant: AppDescriptionView.rightMargin),
            self.appDescriptionTextView.topAnchor
                .constraint(equalTo: self.appVersionDateLabel.bottomAnchor,
                            constant: AppDescriptionView.interlineSpace),
            self.appDescriptionTextView.leadingAnchor
                .constraint(equalTo: self.leadingAnchor,
                            constant: AppDescriptionView.leftMargin),
            self.appDescriptionTextView.trailingAnchor
                .constraint(equalTo: self.trailingAnchor,
                            constant: AppDescriptionView.rightMargin),
            self.appDescriptionTextView.bottomAnchor
                .constraint(equalTo: self.bottomAnchor,
                            constant: AppDescriptionView.bottomMargin)
        ])
    }
}
