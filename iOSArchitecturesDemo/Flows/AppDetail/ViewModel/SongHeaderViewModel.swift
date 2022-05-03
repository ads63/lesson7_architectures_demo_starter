//
//  SongHeaderViewModel.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 28.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SongHeaderViewModel {
    // MARK: - Observable properties

    let model = Observable<SongPlayingModel?>(nil)

    // MARK: - Properties

    private let imageDownloader = ImageDownloader()
    weak var viewController: UIViewController?
    var song: ITunesSong? {
        didSet {
            if let song = song {
                model.value = SongPlayingModel(trackName: song.trackName,
                                               artistName: song.artistName,
                                               collectionName: song.collectionName,
                                               artwork: song.artwork,
                                               country: song.country,
                                               durationMills: song.durationMills,
                                               playState: .notStarted)
            } else {
                model.value = nil
            }
        }
    }

    private let playService: SongPlayServiceInterface

    // MARK: - Init

    init(playService: SongPlayServiceInterface) {
        self.playService = playService
        playService.onProgressUpdate = { [weak self] in
            guard let self = self,
                  let song = self.song,
                  let playingSong = self.playService.playingSong else { return }
            self.model.value = SongPlayingModel(trackName: song.trackName,
                                                artistName: song.artistName,
                                                collectionName: song.collectionName,
                                                artwork: song.artwork,
                                                country: song.country,
                                                durationMills: song.durationMills,
                                                playState: playingSong.playState)
        }
    }

    // MARK: - ViewModel methods

    func didTapPlayButton() {
        guard let song = song else { return }
        switch playService.playingSong?.playState {
        case .notStarted, .none:
            playService.startPlaySong(song)
        case .inProgress:
            playService.stopPlaySong()
        case .isStopped:
            break
        }
    }

    func downloadImage(completion: DownloadImageCompletion?) {
        guard let url = song?.artwork,
              let completion = completion
        else { return }
        imageDownloader.getImage(fromUrl: url, completion: completion)
    }
}
