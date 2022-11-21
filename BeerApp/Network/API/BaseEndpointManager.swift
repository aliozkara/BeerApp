//
//  BaseEndpointManager.swift
//  BeerApp
//
//  Created by alican özkara on 21.11.2022.
//


import Foundation

enum BaseEndpointManager {

    case beers(_ request: BeerRequest)
}

extension BaseEndpointManager: Endpoint {
    
    var baseURL: String {
        return Configuration.baseURL
    }

    var path: String {
        switch self {
        case .beers:
            return "/beers"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .beers:
            return .GET
        }
    }

    var task: HTTPTask {
        switch self {
        case .beers(let request):
            return .requestUrlParameters(urlParameters: request.toDictionary(), additionHeaders: headers)
        }
    }

    var headers: HTTPHeaders? {
        var header = HTTPHeaders()
        header[Headers.Authorization] = ""
        return header
    }

    var contentType: ContentType {
        return .JSON
    }

}
