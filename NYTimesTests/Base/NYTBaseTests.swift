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
    public typealias DataSourceDependency = (
        dataSource: NYTimesDataSourceMock,
        imageDataSource: NYTImageDataSourceMock
    )
}
extension NYTBaseTests where S == NYTBaseTests.DataSourceDependency {
    internal func setup(dataSourceReturn: NYTimesDataSourceMock.Returned, imageDataSourceReturn: NYTImageDataSourceMock.Returned) {
        setUpDependencies()
        guard let dependency else { return }
        
        dependency.dataSource.returned = dataSourceReturn
        dependency.imageDataSource.returned = imageDataSourceReturn
    }
    
    private func setUpDependencies() {
        prepare {
            @Dependency(\.imageSource) var imageSource
            @Dependency(\.mostPopular) var mostPopular
            
            let arg = DataSourceDependency(
                dataSource: mostPopular as! NYTimesDataSourceMock,
                imageDataSource: imageSource as! NYTImageDataSourceMock
            )
            return arg
        }
    }
}
