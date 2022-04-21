//
//  ITunesSong.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 19.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

public struct ITunesSong: Decodable {
    public var trackName: String
    public var artistName: String?
    public var collectionName: String?
    public var artwork: String?
    public var country: String?
    public var durationMills: Int?
    
    // MARK: - Codable
    
    private enum CodingKeys: String, CodingKey {
        case trackName
        case artistName
        case collectionName
        case artwork = "artworkUrl100"
        case country
        case trackTimeMillis
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trackName = try container.decode(String.self, forKey: .trackName)
        self.artistName = try? container.decode(String.self, forKey: .artistName)
        self.collectionName = try? container.decode(String.self, forKey: .collectionName)
        self.artwork = try? container.decode(String.self, forKey: .artwork)
        self.country = try? container.decode(String.self, forKey: .country)
        self.durationMills = try? container.decode(Int.self, forKey: .trackTimeMillis)
    }
    // MARK: - Init
    
    internal init(trackName: String,
                  artistName: String?,
                  collectionName: String?,
                  artwork: String?,
                  country: String?,
                  durationMills: Int?)
    {
        self.trackName = trackName
        self.artistName = artistName
        self.collectionName = collectionName
        self.artwork = artwork
        self.country = country
        self.durationMills = durationMills
    }
}
