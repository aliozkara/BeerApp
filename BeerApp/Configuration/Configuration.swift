//
//  Configuration.swift
//  BeerApp
//
//  Created by alican özkara on 21.11.2022.
//

import Foundation

enum Environment {
    case development
    case production
}

enum Configuration {
    
    static var currentEnvironemnt: Environment {
        #if DEBUG
        return .development
        #else
        return .production
        #endif
    }
    
    static let baseURL: String = {
        switch currentEnvironemnt {
        case .development:
            return "https://api.punkapi.com/v2"
            
        case .production:
            return "https://api.punkapi.com/v2"
        }
    }()
    
}
