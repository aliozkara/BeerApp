//
//  HTTPResponse.swift
//  BeerApp
//
//  Created by alican özkara on 21.11.2022.
//

import Foundation

struct HTTPResponse<T> {
    let value: T
    let response: URLResponse
}
