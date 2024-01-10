//
//  NYTimesEndpoint.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import Network

//https://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?api-key=H0Bhfdr7zoVIQYT2K8ik9UfE1T5pG1WZ

enum NYTimesEndpoint {
    case mostViewed(Int = 1)
}


extension NYTimesEndpoint: Pointable {
    var pointing: String {
        switch self {
        case .mostViewed(let duration):
            return "viewed/\(duration).json?api-key=\(Environment.NYTimes.apiKey)"
        }
    }
    // For Snapshot Testing
    static var allCases: [NYTimesEndpoint] {
        [
            .mostViewed()
        ]
    }
    // For enabling debugger & debugging network call
    var debugID: String {
        "viewed.json"
    }
    // For saving & loading configuration
    var configID: String {
        debugID
    }
}
