//
//  HTTPTask.swift
//  BeerApp
//
//  Created by alican özkara on 21.11.2022.
//

import Foundation


enum HTTPTask {

    case request(bodyEncoding: ParametersEncoding, additionHeaders: HTTPHeaders?)

    case requestBodyParameters(bodyParameters: Parameters,
        bodyEncoding: ParametersEncoding,
        additionHeaders: HTTPHeaders?)

    case requestUrlParameters(urlParameters: Parameters?,
                              additionHeaders: HTTPHeaders?)
}
