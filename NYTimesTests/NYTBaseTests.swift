//
//  NYTBaseTests.swift
//  NYTimesTests
//
//  Created by Apple on 12/01/2024.
//

import Foundation
import XCTest
@testable import NYTimes
import Dependencies

class NYTBaseTests<S>: XCTestCase {
    var dependency: S?
    
    public func prepare(completion: () -> S) {
        self.dependency = completion()
    }
}
extension NYTBaseTests {
    typealias DataSourceDependency = (
        dataSource: NYTimesDataSourceMock,
        imageDataSource: NYTImageDataSourceMock
    )
}
