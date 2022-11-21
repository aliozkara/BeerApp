//
//  HTTPBuilder.swift
//  BeerApp
//
//  Created by alican özkara on 21.11.2022.
//

import Foundation

enum ContentType: String {
    case JSON = "application/json"
    case BODY = "application/x-www-form-urlencoded; charset=utf-8"
}

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}

typealias HTTPHeaders = [String: String]
typealias Parameters = [String: Any]

enum Headers {
    static let Authorization = "Authorization"
    static let ContentType = "Content-Type"
}
