//
//  URLParameterEncoder.swift
//  BeerApp
//
//  Created by alican özkara on 21.11.2022.
//

import Foundation

struct URLParameterEncoder: ParameterEncoders {

    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {

        guard let url = urlRequest.url else { throw NetworkError.missingURL }

        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {

            urlComponents.queryItems = [URLQueryItem]()

            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key,
                                             value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }

        if urlRequest.value(forHTTPHeaderField: Headers.ContentType) == nil {
            urlRequest.setValue(ContentType.BODY.rawValue, forHTTPHeaderField: Headers.ContentType)
        }

    }
}
