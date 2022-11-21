//
//  BeerRequest.swift
//  BeerApp
//
//  Created by alican özkara on 21.11.2022.
//

import Foundation

struct BeerRequest: Codable {
    
    let page: Int
    let perItem: Int
    let beerName: String?
    
    private enum CodingKeys: String, CodingKey {
        case beerName = "beer_name"
        case page, perItem
    }
    
    func toDictionary() -> [String: Any] {
        return self.dictionary ?? [:]
    }
}

