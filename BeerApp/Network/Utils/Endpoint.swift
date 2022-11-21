//
//  Endpoint.swift
//  BeerApp
//
//  Created by alican özkara on 21.11.2022.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    var contentType: ContentType { get }
}
