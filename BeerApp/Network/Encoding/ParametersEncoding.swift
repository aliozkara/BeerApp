//
//  ParametersEncoding.swift
//  BeerApp
//
//  Created by alican özkara on 21.11.2022.
//

import Foundation

protocol ParameterEncoders {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum ParametersEncoding {

    case jsonEncoding
    case urlEncoding

    func encode(urlRequest: inout URLRequest,
                       bodyParameters: Parameters?,
                       urlParameters: Parameters?) throws {

        do {
            switch self {
            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }

}
