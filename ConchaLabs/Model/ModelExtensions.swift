//
//  ModelExtensions.swift
//  ConchaLabs
//
//  Created by Alexis Diaz on 3/23/22.
//

import Foundation

extension SliderResults: Decodable {
    enum CodingKeys: String, CodingKey {
        case ticks
        case sessionID = "session_id"
        case stepCount = "step_count"
        case complete
        case error
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sessionID = try container.decode(Int.self, forKey: .sessionID)
        
        let stepCount = try container.decodeIfPresent(Int.self, forKey: .stepCount)
        let ticks = try container.decodeIfPresent([Double].self, forKey: .ticks)
        let complete = try container.decodeIfPresent(String.self, forKey: .complete)
        let error = try container.decodeIfPresent(String.self, forKey: .error)
        
        if complete == "true" {
            self.type = .completed(isCompleted: complete ?? "")
        } else if let error = error {
            self.type = .error(error)
        } else {
            guard let stepCount = stepCount,
                  let ticks = ticks
            else { fatalError("Missing values!") }
            self.type = .step(ticks: ticks, stepCount: stepCount)
        }
    }
}
