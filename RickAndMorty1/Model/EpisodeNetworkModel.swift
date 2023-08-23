//
//  LocalModel.swift
//  RickAndMorty
//
//  Created by Alex Aytov on 18.08.2023.
//

import Foundation

// MARK: - EpisodeNetworkModel
struct EpisodeNetworkModel: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
