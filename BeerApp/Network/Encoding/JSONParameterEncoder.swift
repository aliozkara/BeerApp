//
//  JSONParameterEncoder.swift
//  BeerApp
//
//  Created by alican özkara on 21.11.2022.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoders {

    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
        } catch {
            throw NetworkError.encodingFailed
        }
    }

}
