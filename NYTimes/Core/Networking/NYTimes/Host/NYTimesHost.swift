//
//  NYTimesHost.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import Foundation
import Network

public struct NYTimesHost: Hosting {
    public let scheme: String
    public let host: String
    public let port: Int = 0
    public let path: String
    
    public init() {
        self.scheme = "https"
        self.host = "api.nytimes.com"
        self.path = "svc/mostpopular/v2"
    }
}
