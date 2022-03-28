//
//  APIService.swift
//  ConchaLabs
//
//  Created by Alexis Diaz on 3/24/22.
//

import Foundation

struct APIService {
    
    private let session: Session
    
    init(session: Session = URLSession.shared) {
        self.session = session
    }
    
    func request(for endpoint: APIService.Endpoint) -> URLRequest {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = "POST"
        request.httpBody = endpoint.body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    enum Endpoint {
        case testStart
        case testNext(sessionID: Int, choice: Int)
        
        var baseURL: URL { URL(string: "https://iostestserver-su6iqkb5pq-uc.a.run.app")! }
        
        var url: URL {
            switch self {
                case .testStart:
                    return baseURL.appendingPathComponent("/test_start")
                case .testNext:
                    return baseURL.appendingPathComponent("/test_next")
            }
        }
        
        var body: Data? {
            let encoder = JSONEncoder()
            switch self {
                case .testStart:
                    let body = RequestBody(choice: "start", session_id: nil)
                    return try? encoder.encode(body)
                    
                case let .testNext(sessionID, choice):
                    let body = RequestBody(choice: "\(choice)", session_id: sessionID)
                    return try? encoder.encode(body)
                    
            }
        }
    }
}



