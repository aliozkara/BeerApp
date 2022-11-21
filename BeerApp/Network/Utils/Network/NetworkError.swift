//
//  NetworkError.swift
//  BeerApp
//
//  Created by alican özkara on 21.11.2022.
//

import Foundation

public enum NetworkError: String, Error {
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
