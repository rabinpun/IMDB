//
//  APIService.swift
//  Uikit
//
//  Created by Rabin Pun on 12/06/2025.
//

import Foundation

protocol APIService {
    func fetch<T: Decodable>(_ request: APIRequest) async throws -> T
}

/// IAPIService: Here I stands for implementation
class IAPIService: APIService {
    func fetch<T: Decodable >(_ request: APIRequest) async throws -> T {
        let urlRequest = try request.getURLRequest()
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
            let error = try JSONDecoder().decode(APIError.self, from: data)
            throw error
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

}
