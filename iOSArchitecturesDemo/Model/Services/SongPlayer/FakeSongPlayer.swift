//
//  FakeSongPlayer.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 27.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
protocol SongPlayServiceInterface: class {
    var playingSong: PlayingSong? { get }
    var onProgressUpdate: (() -> Void)? { get set }
    func startPlaySong(_ song: ITunesSong)
    func stopPlaySong()
}

final class PlayingSong {
    enum PlayState {
        case notStarted
        case inProgress(progress: Double)
        case isStopped
    }

    let song: ITunesSong
    var playState: PlayState = .notStarted
    init(song: ITunesSong) {
        self.song = song
    }
}

final class FakePlaySongService: SongPlayServiceInterface {
    // MARK: - SongPlayServiceInterface

    private(set) var playingSong: PlayingSong?
    var onProgressUpdate: (() -> Void)?

    func stopPlaySong() {
        self.playingSong?.playState = .isStopped
    }

    func startPlaySong(_ song: ITunesSong) {
        let playingSong = PlayingSong(song: song)
        self.playingSong = playingSong
        self.startTimer(for: playingSong)
    }

    // MARK: - Private properties

    private var timer: Timer?

    // MARK: - Private

    private func startTimer(for playingSong: PlayingSong) {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) {
            [weak self] timer in
            switch playingSong.playState {
            case .notStarted:
                playingSong.playState = .inProgress(progress: 0.5)
            case .inProgress(let progress):
                let newProgress = progress + 0.5
                if newProgress >= Double(playingSong.song.durationMills ?? 0 / 1000) {
                    playingSong.playState = .isStopped
                    self?.invalidateTimer(timer)
                } else {
                    playingSong.playState = .inProgress(progress:
                        progress + 0.5)
                }
            case .isStopped:
                self?.invalidateTimer(timer)
                playingSong.playState = .notStarted
            }
            self?.onProgressUpdate?()
        }
        RunLoop.main.add(self.timer!, forMode: .common)
    }

    private func invalidateTimer(_ timer: Timer) {
        timer.invalidate()
    }
}
