//
//  LocationNetworkModel.swift
//  RickAndMorty
//
//  Created by Alex Aytov on 22.08.2023.
//

import Foundation

struct LocationNetworkModel: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
    
    init() {
        self.id = 0
        self.name = "Unknown"
        self.type = ""
        self.dimension = "Unknown"
        self.residents = ["Unknown"]
        self.url = "Unknown"
        self.created = "Unknown"
    }
}
