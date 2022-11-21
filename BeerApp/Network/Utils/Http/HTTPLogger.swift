//
//  HTTPLogger.swift
//  BeerApp
//
//  Created by alican özkara on 21.11.2022.
//

import Foundation

class HTTPLogger {
    
    static func log(request: URLRequest) {


        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }

        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)

        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"

        var logOutput = """
                        \(urlAsString) \n\n
                        \(method) \(path)?\(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        """
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }

        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }

        print(logOutput)
    }

    static func log(response: URLResponse, data: Data? = nil) {

        var logString = "\n📥"

        if let httpResponse = response as? HTTPURLResponse {
                    let localisedStatus = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode).capitalized
                    logString += "Status: \n  \(httpResponse.statusCode) - \(localisedStatus)\n"
                }

        guard let data = data else { return }

                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    let pretty = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)

                    if let string = NSString(data: pretty, encoding: String.Encoding.utf8.rawValue) {
                        logString += "\nJSON: \n\(string)"
                    }
                }
                catch {
                    if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                        logString += "\nData: \n\(string)"
                    }
                }

        logString += "\n\n*************************\n\n"
        print(logString)
    }
}
