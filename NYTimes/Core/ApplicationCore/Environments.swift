//
//  ApplicationCore.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import Foundation

public struct Environment {
    public struct NYTimes {
        public static var apiKey: String { ProcessInfo.processInfo.environment["NYTimes_API_Key"] ?? "" }
    }
}
