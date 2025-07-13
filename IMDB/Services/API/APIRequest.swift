//
//  APIRequest.swift
//  Uikit
//
//  Created by Rabin Pun on 12/06/2025.
//

import Foundation

struct APIRequest {
    let endPoint: APIEndpoint
    let body: Codable?
    let parameters: DictionaryConvertible?
    
    init(endPoint: APIEndpoint, body: Codable? = nil, parameters: DictionaryConvertible? = nil) {
        self.endPoint = endPoint
        self.body = body
        self.parameters = parameters
    }
    
    /// Makes the required url request based on the end point, parameter and body
    /// - Returns: Returns the configured URLRequest
    func getURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents(string: endPoint.urlString)!

        /// Add the query parameters to the URL.
        urlComponents.queryItems = parameters?.toDict().compactMap { key, value in
            if let value = value as? String {
                return URLQueryItem(name: key, value: value)
            }
            return nil
        }

        /// Ensure we have a valid URL and throw a URLError if it fails.
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        
        /// Configure the HTTP method.
        urlRequest.httpMethod = endPoint.httpMethod
        
        /// Configure the proper content-type value to JSON.
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        
        if (endPoint.requiresAuthorization) {
            urlRequest.setValue("Bearer " + Constants.accessToken, forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
}
