//
//  SongDetailHeaderViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 19.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit

final class SongDetailHeaderViewController: UIViewController {
    // MARK: - Properties

    private let viewModel: SongHeaderViewModel?

    private var songDetailHeaderView: SongDetailHeaderView {
        return self.view as! SongDetailHeaderView
    }

    // MARK: - Init

    init(viewModel: SongHeaderViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        self.view = SongDetailHeaderView()
        self.bindViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private

    private func bindViewModel() {
        self.songDetailHeaderView.onPlayButtonTap = {
            [weak self] in self?.viewModel?.didTapPlayButton()
        }
        self.viewModel?.model.addObserver(self) {
            [weak self] data, _ in
            switch data?.playState {
            case .isStopped:
                setStopedProgressControlValues(start: 0,
                                               end: (data?.durationMills ?? 0) / 1000)
            case .notStarted, .none:
                setInitialControlValues(start: 0,
                                        end: (data?.durationMills ?? 0) / 1000)
            case .inProgress(let progress):
                let progressState = progress / Double((data?.durationMills ?? 0) / 1000)
                setProgressControlValues(progress: Float(progressState),
                                         start: Int(progress),
                                         end: Int((data?.durationMills ?? 0) / 1000 - Int(progress)))
            }
            func setStopedProgressControlValues(start: Int, end: Int) {
                self?.songDetailHeaderView
                    .playButton
                    .setTitle("Play", for: .normal)
                self?.songDetailHeaderView.progressBar.progress = 0.0
                setProgressLabels(start: start, end: end)
            }
            func setInitialControlValues(start: Int, end: Int) {
                setStopedProgressControlValues(start: start, end: end)
                self?.songDetailHeaderView.titleLabel.text = data?.trackName
                self?.songDetailHeaderView.subtitleLabel.text = data?.artistName
                self?.viewModel?.downloadImage { image, _ in
                    self?.songDetailHeaderView.imageView.image = image
                }
            }
            func setProgressControlValues(progress: Float, start: Int, end: Int) {
                self?.songDetailHeaderView
                    .playButton
                    .setTitle("Stop", for: .normal)
                self?.songDetailHeaderView.progressBar.progress = progress
                setProgressLabels(start: start, end: end)
            }
            func setProgressLabels(start: Int, end: Int) {
                self?.songDetailHeaderView.leftPlayLabel.text =
                    getStringDuration(duration: start)
                self?.songDetailHeaderView.rightPlayLabel.text =
                    getStringDuration(duration: end)
            }
            func getStringDuration(duration: Int) -> String {
                let minutes = duration / 60
                let seconds = duration % 60
                return (minutes < 10 ? "0\(minutes)" : "\(minutes)") + ":"
                    + (seconds < 10 ? "0\(seconds)" : "\(seconds)")
            }
        }
    }
}
