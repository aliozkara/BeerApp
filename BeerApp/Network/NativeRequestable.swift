//
//  NativeRequestable.swift
//  BeerApp
//
//  Created by alican özkara on 21.11.2022.
//


import Combine
import Foundation

class NativeRequestable: Requestable {
    
    func perform<T>(_ req: Endpoint) async throws -> T where T : Decodable {
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(30.0)

        guard let url = URL(string: req.baseURL) else {
            throw NetworkError.missingURL
        }
        
        var request = URLRequest(url: url.appendingPathComponent(req.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 60.0)

        request.httpMethod = req.httpMethod.rawValue
        
        do {
            request.setValue(req.contentType.rawValue, forHTTPHeaderField: Headers.ContentType)
            switch req.task {
            case .request(let bodyEncoding, let additionHeaders):
                self.addAdditionalHeaders(additionHeaders, request: &request)
                try self.configureParameters(bodyParameters: nil,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: nil,
                                             request: &request)
            case .requestBodyParameters(let bodyParameters, let bodyEncoding, let additionHeaders):
                self.addAdditionalHeaders(additionHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: nil,
                                             request: &request)
            case .requestUrlParameters(urlParameters: let urlParameters, additionHeaders: let additionHeaders):
                self.addAdditionalHeaders(additionHeaders, request: &request)
                try self.configureParameters(bodyParameters: nil,
                                             bodyEncoding: .urlEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
        } catch {
            throw NetworkError.encodingFailed
        }
        
        HTTPLogger.log(request: request)

        do {
            let (result, response) = try await URLSession.shared.data(urlRequest: request)
            
            // HTTPLogger.log(response: response, data: result)

            if let httpResponse = response as? HTTPURLResponse {
                if let error = self.handleErrorResponse(httpResponse) {
                    throw error
                }
            }
            
            let data = try JSONDecoder().decode(T.self, from: result)
            return data
        } catch {
            throw HTTPError.invalidJSON(error.localizedDescription)
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParametersEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw NetworkError.encodingFailed
        }
    }

    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    fileprivate func handleErrorResponse(_ response: HTTPURLResponse) -> HTTPError? {
        switch response.statusCode {
        case 200...204:
            return nil
        case 401, 407:
            return .unauthorized
        case 400, 404, 405, 408, 409:
            return .badRequest
        case 500...511:
            return .serverError
        default:
            return .failed
        }
    }
}
