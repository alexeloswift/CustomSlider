//
//  Session.swift
//  ConchaLabs
//
//  Created by Alexis Diaz on 3/24/22.
//

import Foundation

protocol Session {
    func makeRequest(_ request: URLRequest) async throws -> Data?
}

extension URLSession: Session {
    func makeRequest(_ request: URLRequest) async throws -> Data? {
        let (data, response) = try await self.data(for: request)
        //        print(#function, String(data: data, encoding: .utf8))
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
              statusCode >= 200,
              statusCode < 300
        else { throw NetworkError.error(String(data: data, encoding: .utf8)!) }
        return data
    }
}
