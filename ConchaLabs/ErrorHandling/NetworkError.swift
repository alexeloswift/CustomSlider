//
//  NetworkError.swift
//  ConchaLabs
//
//  Created by Alexis Diaz on 3/24/22.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case error(String)

    var errorDescription: String? {
        switch self {
        case .error(let content):
            return "Network error: \(content)"
        }
    }
}
