//
//  Requestable.swift
//  BeerApp
//
//  Created by alican özkara on 21.11.2022.
//

import Foundation

protocol Requestable {

    func perform<T: Decodable>(_ req: Endpoint) async throws -> T
}
