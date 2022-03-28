//
//  Network.swift
//  ConchaLabs
//
//  Created by Alexis Diaz on 3/23/22.
//

import Foundation

class Network {
    
    let session: Session
    
    init(session: Session = URLSession.shared) {
        self.session = session
    }
    
    func makeRequest<T: Decodable>(for request: URLRequest) async throws -> T {
        print(#function, request, T.Type.self)
        guard let data = try await session.makeRequest(request)
        //        else { throw NetworkError.error("Unknown") }
        else { fatalError("") }
        //        print(#function, String(data: data, encoding: .utf8))
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}


