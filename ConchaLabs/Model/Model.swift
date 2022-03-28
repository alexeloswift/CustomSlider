//
//  Model.swift
//  ConchaLabs
//
//  Created by Alexis Diaz on 3/22/22.
//

import Foundation

struct SliderResults {
    enum SliderResultType {
        case step(ticks: [Double], stepCount: Int)
        case completed(isCompleted: String)
        case error(String)
    }
    
    let type: SliderResultType
    let sessionID: Int
    
    var ticks: [Double] {
        switch type {
        case .step(let ticks, _):
            return ticks
        default:
            return []
        }
    }
    
    var stepCount: Int {
        switch type {
        case .step(_, let stepCount):
            return stepCount
        default:
            return -1
        }
    }
    
    var isCompleted: String {
        switch type {
            case .completed(let isCompleted):
                return isCompleted
            default:
                return ""

        }
    }
}

struct RequestBody: Encodable {
    let choice: String
    let session_id: Int? 
}




