//
//  Encodable.swift
//  BeerApp
//
//  Created by alican özkara on 21.11.2022.
//

import Foundation

extension Encodable {

    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
