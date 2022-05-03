//
//  SearchInteractorInput.swift
//  iOSArchitecturesDemo
//
//  Created by Алексей Шинкарев on 25.04.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import Alamofire

protocol SearchInteractorInput {
    func requestSongs(with query: String, completion: @escaping
        (Result<[ITunesSong]>) -> Void)
}

