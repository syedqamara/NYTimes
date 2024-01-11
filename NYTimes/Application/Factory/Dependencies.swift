//
//  Dependencies.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import Foundation
import Dependencies

enum NYTimesDataSourceKey: DependencyKey, TestDependencyKey {
    static var liveValue: any NYTimesDataSourcing = NYTimesDataSources()
    static var testValue: any NYTimesDataSourcing = NYTimesDataSources()
}

enum NYTimesImageDataSourceKey: DependencyKey, TestDependencyKey {
    static var liveValue: any NYTimesImageDataSourcing = NYTimesImageDataSource()
    static var testValue: any NYTimesImageDataSourcing = NYTimesImageDataSource()
}


extension DependencyValues {
    var mostPopular: any NYTimesDataSourcing {
        get {
            self[NYTimesDataSourceKey.self]
        }
        set {
            self[NYTimesDataSourceKey.self] = newValue
        }
    }
    var imageSource: any NYTimesImageDataSourcing {
        get {
            self[NYTimesImageDataSourceKey.self]
        }
        set {
            self[NYTimesImageDataSourceKey.self] = newValue
        }
    }
}
