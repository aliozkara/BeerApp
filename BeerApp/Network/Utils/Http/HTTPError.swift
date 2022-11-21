//
//  HTTPError.swift
//  BeerApp
//
//  Created by alican özkara on 21.11.2022.
//

import Foundation

enum HTTPError: Error, Equatable {
    case badURL
    case invalidJSON(_ error: String)
    case unauthorized
    case badRequest
    case failed
    case serverError
}
