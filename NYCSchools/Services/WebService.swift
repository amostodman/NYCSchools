//
//  WebService.swift
//  NYCSchools
//
//  Created by Amos Todman on 1/12/24.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decodingError
}

import Foundation

class WebService {
    func get<T: Decodable>(url: URL, parse: (Data) -> T?) async throws -> T {
        let (data, urlResponse) = try await URLSession.shared.data(from: url)
        guard
            let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode,
            statusCode >= 200 && statusCode < 300
        else {
            print(urlResponse)
            throw NetworkError.badRequest
        }
        
        guard let result = parse(data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
    
    func loadJson<T: Decodable>(filename fileName: String, parse: (Data) -> T?) throws -> T {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw NetworkError.badRequest
        }
        
        let data = try Data(contentsOf: url)

        guard let result = parse(data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
}
